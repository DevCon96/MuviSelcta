//
//  TitleListView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import SwiftUI
import CoreData

fileprivate let movies: [String] = ["The Imitation Game", "8 Mile", "Green Mile", "Glsss Onion", "Knives Out", "Madoff"]
fileprivate let series: [String] = ["The Big Bang Theory", "The Office", "Peep Show", "Breaking Bad", "Better Call Saul"]

struct MuviDashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Title.title, ascending: true)],
        animation: .default)
    private var titles: FetchedResults<Title>

    @StateObject private var viewModel = MoviesDashboardViewModel()
    @State var genre: IMDBApi.Genre = .action
        var body: some View {
            VStack {
            HStack {
                VStack {
                    Button("Download Top 5") {
                        Task {
                            _ = await viewModel.getMostPopularMovies(genre, count:5)
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                    .buttonStyle(.borderless)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 2)
                            .shadow(radius: 5)
                            .frame(width:((UIScreen.main.bounds.size.width / 2) - 25))
                    )

                    Picker("Genre", selection: $genre) {
                        ForEach(IMDBApi.Genre.allCases) { genre in
                            Text(genre.rawValue.capitalized).tag(genre)
                        }

                    }
                    .frame(height: 100)
                    .tint(Color(UIColor.lightGray))
                    .pickerStyle(.wheel)
                    .foregroundColor(.black)
                }
            }
            if viewModel.downloadedGenres.count == 0 {
                // Display nothing
                Spacer()
            } else {
                ForEach(viewModel.downloadedGenres) { genre in
                    let genreSpecificTitles = titles.filter { $0.genre == genre.rawValue }

                    Text(genre.rawValue.capitalized)
                    List(genreSpecificTitles) { title in
                        SingleTitleView(title: title)
                    }
                    .shadow(radius: 15)
                }
            }
        }
    }
}

extension MuviDashboardView {
    enum SelectedView: String {
        case movie = "Movie"
        case series = "Series"
        case top10Movies = "Top 10 Movies"
        case top10Series = "Top 10 Series"
        case nonSelected = ""
    }

    @MainActor class MoviesDashboardViewModel: ObservableObject {
        @Published private(set) var selectedTitle: TitleDetailsResponse?
        @Published var currentTitleList: [TitleDetailsResponse] = []
        @Published var state: SelectedView = .nonSelected
        @Published var downloadedGenres = [IMDBApi.Genre]()

        var viewContext = PersistenceController.shared.persistentContainer.viewContext

        func insertTitleToDB(_ title: TitleDetailsResponse) {
            withAnimation {
                let newTitle = Title(context: viewContext)
                newTitle.title = title.title
                newTitle.movieLength = Int16(title.movieLength)
                newTitle.year = Int16(title.year)
                newTitle.nextEpisode = title.nextEpisode
                newTitle.numberOfEpisodes = Int16(title.numberOfEpisodes ?? 1)
                newTitle.seriesEndYear = Int16(title.seriesEndYear ?? title.year)
                newTitle.seriesStartYear = Int16(title.seriesStartYear ?? title.year)
                newTitle.id = title.id
                newTitle.titleType = title.titleType
                newTitle.genre = title.genre?.rawValue

                do {
                    try viewContext.save()
                    log(.info, "Inserted title into database - \(title.title)")
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }

        // TODO: Rename this to Download or fetch rather than get. This will eventually not return anything
        func getMostPopularMovies(_ genre: IMDBApi.Genre, count: Int = 1) async  -> [TitleDetailsResponse] {
            var result: [TitleDetailsResponse] = []

            downloadedGenres.append(genre)

            do {
                let movieIds = try await IMDBApi.getPopularMovies(for: genre, count: count)
                for titleID in movieIds {
                    if var title = try await IMDBApi.getTitleDetails(for: titleID) {
                        title.genre = genre
                        result.append(title)
                        self.insertTitleToDB(title)
                    }
                }
            } catch {
                log(.error, "Could not get movies for genre \"\(genre.rawValue)\"")
            }

            return result
        }
    }
}
#if DEBUG
struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        MuviDashboardView().environment(\.managedObjectContext, PersistenceController.shared.persistentContainer.viewContext)
    }
}
#endif
