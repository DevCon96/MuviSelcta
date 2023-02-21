//
//  CreateNewWatchlistView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/02/2023.
//

import SwiftUI

struct CreateNewWatchlistView: View {
    @StateObject var viewModel = CreateNewWatchlistViewModel()
    @State var newWatchListName: String

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(!newWatchListName.isEmpty ? newWatchListName : Strings.createNewWatchlistTitle)
                        .foregroundColor(.brandDarkBlue)
                        .font(.title2)
                        .padding()
                    TextField("", text: $newWatchListName)
                        .foregroundColor(.brandDarkBlue)
                        .font(.title2)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .placeholder(when: newWatchListName.isEmpty) {
                            Text(Strings.newWatchListNamePlaceholder)
                                .foregroundColor(Color(uiColor: .lightGray))
                        }
                    ForEach(IMDBApi.Genre.allCases) { genre in
                        if genre != .unknown {
                            HStack {
                                if viewModel.watchlistGenres[genre] ?? false {
                                    CheckCheckBoxView {
                                        viewModel.watchlistGenres[genre]?.toggle()
                                    }
                                } else {
                                    UncheckCheckBoxView {
                                        viewModel.watchlistGenres[genre]?.toggle()
                                    }
                                }

                                Text(genre.rawValue.capitalized)
                            }
                            .padding()
                        }
                    }
                }
            }

            HStack {
                Button(Strings.saveButtonTitle) {
                    
                }
            }
        }
    }

}

extension CreateNewWatchlistView {
    @MainActor
    public class CreateNewWatchlistViewModel: ObservableObject {
        @Published var watchlistGenres: [IMDBApi.Genre : Bool] = [:]
        @Published var watchlistInitialTitles = [Title]()

        init() {
            for genre in IMDBApi.Genre.allCases {
                watchlistGenres[genre] = false
            }
        }

    }
}

struct CreateNewWatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewWatchlistView(newWatchListName: "")
    }
}
