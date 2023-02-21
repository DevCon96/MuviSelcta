//
//  DownloadNewMoviesView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 29/01/2023.
//

import SwiftUI

struct DownloadNewMoviesView: View {
    @StateObject private var viewModel = DownloadNewMoviesViewModel()
    @State private var genreSelected: IMDBApi.Genre = .unknown

    var body: some View {
        VStack {
            Text("Download new titles")
                .foregroundColor(.brandYellow)
                .font(.title)
            Button("Download Top 5") {
                Task {
                    _ = await viewModel.getMostPopularMovies(genreSelected, count:5)
                }
            }
            .padding([.bottom], 5)
            .frame(maxWidth: .infinity)
            .buttonStyle(PrimaryButton())

            Form {
                Section {
                    Picker(selection: $genreSelected, label:
                            Text(Strings.genreSelectorTitle).foregroundColor(.brandOrange).font(.headline)) {
                        ForEach(IMDBApi.Genre.allCases) { genre in
                            Text(genre.rawValue.capitalized)
                                .foregroundColor(.brandWhite)
                                .background(Color.brandLightBlue)
//                                .background(Color.brandDarkBlue)
                        }
                    }

                }
            }
            .background(Color.brandLightBlue)
            .tint(Color.brandLightBlue)
        }
        .preferredColorScheme(.light)
        .background(Color.brandLightBlue)
    }
}

extension DownloadNewMoviesView {
    class DownloadNewMoviesViewModel: ObservableObject {
        @Published private(set) var selectedTitle: TitleDetailsResponse?
        @Published var currentTitleList: [TitleDetailsResponse] = []
        @Published var downloadedGenres = [IMDBApi.Genre]()

        var viewContext = PersistenceController.shared.persistentContainer.viewContext

        //TODO: Move this functionality into the persistence controller class
        private func insertTitleToDB(_ title: TitleDetailsResponse) {
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

struct DownloadNewMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadNewMoviesView()
    }
}
