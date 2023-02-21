//
//  ActionTitlesView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 29/01/2023.
//

import SwiftUI
import CoreData

struct GenreSpecificTitlesView: View {
    @State private var titles = [Title]()
    @State private var state: IMDBApi.Genre
    @StateObject var viewModel = GenreSpecificTitlesViewModel()

    var body: some View {
        VStack {
            List(viewModel.titles) { title in
                SingleTitleView(title: title)
            }
            Text("\(state.rawValue.capitalized) Titles")
                .padding()
        }
        .onAppear {
            log(.info, "Number of titles of genre \(viewModel.titles.count)")
            viewModel.updateTitleList(genre: state)
        }
    }

    init(state: IMDBApi.Genre) {
        self.state = state
    }
}

extension GenreSpecificTitlesView {
    @MainActor class GenreSpecificTitlesViewModel: ObservableObject {
        private var viewContext: NSManagedObjectContext = PersistenceController.shared.persistentContainer.viewContext
        @Published var state: IMDBApi.Genre = .unknown
        @Published var titles = [Title]()

        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Title.title, ascending: true)],
            animation: .default)
        private var fetchedTitles: FetchedResults<Title>

        public func updateTitleList(genre: IMDBApi.Genre) {
            var genreTitles = [Title]()
            for title in fetchedTitles {
                if let fetchedTitleGenre = title.genre, fetchedTitleGenre == genre.rawValue {
                    genreTitles.append(title)
                }
            }
            titles = genreTitles
        }
    }
}

struct ActionTitlesView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSpecificTitlesView(state: .action)
    }
}
