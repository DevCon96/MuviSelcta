//
//  IMDBApi.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import Foundation
import CoreData
import SwiftUI

fileprivate let timeoutInterval = 10.0


class IMDBApi {
    private static let apiKey = ""//"f00295303dmsh8abbb960a723b5cp15819fjsnfe700d92d7ad"
    private static let hostUrl = "" //"imdb8.p.rapidapi.com"
    
    private static let headers = [
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": hostUrl
    ]
    
    private static var viewContext: NSManagedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    /* action|adventure|animation|biography|comedy|crime|documentary|drama|family|fantasy|film-noir|game-show||history|horror|music|musical|mystery|news|reality-tv|romance|sci-fi|short|sport|talk-show|thriller|war|western
     */
    enum Genre: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case action = "action"
        case adventure = "adventure"
        case animation = "animation"
        case biography = "biography"
        case comedy = "comedy"
        case crime = "crime"
        case documentary = "documentary"
        case drama = "drama"
        case family = "family"
        case fantasy = "fantasy"
        case filmNoir = "film-noir"
        case gameShow = "game-show"
        case history = "history"
        case horror = "horror"
        case music = "music"
        case musical = "musical"
        case mystery = "mystery"
        case news = "news"
        case realityTv = "reality-tv"
        case romance = "romance"
        case scifi = "sci-fi"
        case short = "short"
        case sport = "sport"
        case talkShow = "talk-show"
        case thriller = "thriller"
        case war = "war"
        case western = "western"
        case unknown = ""
    }
    
    enum Result {
        case success(Data)
        case failure(Error)
    }
    
    // MARK: - Get top (1 by default) Movies for a given genre
    
    static func getPopularMovies(for genre: Genre, count: Int = 1) async throws -> [String]  {
        var responseData: [String] = []
        let apiMethod = "get-popular-movies-by-genre"
        let request = NSMutableURLRequest(url: NSURL(string: "https://\(hostUrl)/title/v2/\(apiMethod)?genre=\(genre.rawValue)&limit=\(String(count))")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            let titleComponents = String(data: data, encoding: .utf8)!
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: "\"/title/", with: "")
                .replacingOccurrences(of: "/\"", with: "")
                .components(separatedBy: ",")
            titleComponents.forEach { responseData.append($0) }
        } catch {
            throw MovieSearcherError.noDataFetched
        }
        
        return responseData
    }
    
    // MARK: - Get title details for title (tconst) id
    
    static func getTitleDetails(for id: String) async throws -> TitleDetailsResponse? {
        var result: TitleDetailsResponse?
        let apiMethod = "get-details"
        let request = NSMutableURLRequest(url: NSURL(string: "https://\(hostUrl)/title/\(apiMethod)?tconst=\(id)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        // Check Database before making API call
        let resultFromDB = checkDatabase(titleID: id)
        
        if let resultFromDB {
            result = TitleDetailsResponse(entity: resultFromDB)
            return result
        }
        
        // Not found in DB, call API to get title data
        do {
            let (data, _) = try await URLSession.shared.data(for: request as URLRequest)
            result = try? JSONDecoder().decode(TitleDetailsResponse.self, from: data)
        } catch {
            log(.error, "Data not found from API call")
            throw MovieSearcherError.noDataFetched
        }
        
        return result
    }
    
    // Returns nil if title is not in DB
    private static func checkDatabase(titleID: String) -> Title? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        fetchRequest.predicate = NSPredicate(format: "id = %@", titleID)
        
        var resultTitle: Title?
        
        do {
            let result = try viewContext.fetch(fetchRequest) as! [Title]
            resultTitle = result.first
            log(.info, "Found title for id \(titleID) in DB")
        } catch {
            log(.error, "Fetch request failed")
        }
        
        return resultTitle
    }
}

enum MovieSearcherError: Error {
    case noDataFetched
}

enum CDEntityNames: String {
    case titleID = "id"
case title = "title"
}
