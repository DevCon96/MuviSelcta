//
//  IMDBResponses.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import Foundation

struct TitleDetailsResponse: Codable, Identifiable {
    var type: String
    var id: String
    var image: TitlePosterInformation
    var movieLength: Int
    var nextEpisode: String?
    var numberOfEpisodes: Int?
    var seriesEndYear: Int?
    var seriesStartYear: Int?
    var title: String
    var titleType: String
    var year: Int
    var genre: IMDBApi.Genre?

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case id = "id"
        case image = "image"
        case movieLength = "runningTimeInMinutes"
        case nextEpisode = "nextEpisode"
        case numberOfEpisodes = "numberOfEpisodes"
        case seriesEndYear = "seriesEndYear"
        case seriesStartYear = "seriesStartYear"
        case title = "title"
        case titleType = "titleType"
        case year = "year"
    }

    init(type: String,image: TitlePosterInformation, id: String, movieLength: Int, nextEpisode: String, numberOfEpisodes: Int, seriesEndYear: Int, seriesStartYear: Int, title: String, titleType: String, year: Int) {
        self.type = type
        self.titleType = titleType
        self.title = title
        self.nextEpisode = nextEpisode
        self.year = year
        self.id = id
        self.seriesStartYear = seriesStartYear
        self.seriesEndYear = seriesEndYear
        self.movieLength = movieLength
        self.numberOfEpisodes = numberOfEpisodes
        self.image = image//TitlePosterInformation(id: "N/A", url: "N/A", height: 50, width: 50)
    }

//  Initialiser used to create from DB entity
    init(entity: Title) {
        self.type = "coredata"
        self.titleType = entity.titleType ?? "N/A"
        self.title = entity.title ?? "N/A"
        self.nextEpisode = entity.nextEpisode ?? "N/A"
        self.year = Int(entity.year)
        self.id = entity.id ?? "N/A"
        self.seriesStartYear = Int(entity.seriesStartYear)
        self.seriesEndYear = Int(entity.seriesEndYear)
        self.movieLength = Int(entity.movieLength)
        self.numberOfEpisodes = Int(entity.numberOfEpisodes)
        self.image = TitlePosterInformation(id: "N/A", url: "N/A", height: 50, width: 50)
    }
}

struct TitlePosterInformation: Codable {
    var id: String
    var url: String
    var height: Int
    var width: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case height = "height"
        case width = "width"
    }
}
