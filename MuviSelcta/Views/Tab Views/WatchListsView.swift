//
//  WatchListsView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 10/02/2023.
//

import SwiftUI

fileprivate let testTitleImageData = TitlePosterInformation(
    id: "image-test-id",
    url: "image-test-url",
    height: 100,
    width: 100
    )
fileprivate let testTitle = TitleDetailsResponse(
    type: "title",
    image: testTitleImageData,
    id: "tt575574899857439",
    movieLength: 136,
    nextEpisode: "Test Movie Name",
    numberOfEpisodes: 1,
    seriesEndYear: 2023,
    seriesStartYear: 2023,
    title: "Title of movie",
    titleType: "movie",
    year: 2023)

struct WatchListsView: View {
    @ObservedObject var viewModel = WatchListViewModel()
    @State private var isShowingCreateNewWatchlistView = false

    var body: some View {
        NavigationStack {
            VStack {
                Text(Strings.watchlisViewtTitle)
                    .foregroundColor(.brandYellow)
                    .font(.title2)
                List(viewModel.watchLists) { watchlist in
                    NavigationLink(watchlist, value: watchlist)

                }.onAppear {
                    viewModel.createWatchList(name: "Favs")
                }

                .navigationSplitViewStyle(.prominentDetail)
                .listStyle(.sidebar)
                .foregroundColor(.brandDarkBlue)
                .background(Color.brandYellow)

                HStack {
                    Button(Strings.createNewWatchlist) {
                        isShowingCreateNewWatchlistView.toggle()
                    }
                    .buttonStyle(PrimaryButton())
                    .sheet(isPresented: $isShowingCreateNewWatchlistView) {
                        CreateNewWatchlistView(newWatchListName: Strings.newWatchListNamePlaceholder)
                    }

                    Button(Strings.deleteWatchList) {
                        log(.info, "delete custom watchlost pressed")
                    }
                    .buttonStyle(SecondaryButton())
                }
                .background(Color.brandLightBlue)
            }
            .background(Color.brandLightBlue)
        }
        .navigationDestination(for: String.self) { _ in
            SingleTitleView(title: testTitle)
        }
    }
}

extension WatchListsView {
    @MainActor public class WatchListViewModel: ObservableObject {
        @Published var watchLists = [String]()
        @Published var selectedWatchlist = "" {
            didSet {
                print("Watchlist selected \(selectedWatchlist)")
            }
        }

        func createWatchList(name: String) {
            guard !watchLists.contains(name) else { return }
            watchLists.append(name)
        }

        func deleteWatchList(name: String) {
            for i in 0..<watchLists.count {
                if watchLists[i] == name {
                    watchLists.remove(at: i)
                }
            }
        }

        func selectWatchlist(name: String) {
            guard watchLists.contains(name) else { return }

            selectedWatchlist = name
        }
    }
}
struct WatchListsView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListsView()
    }
}
