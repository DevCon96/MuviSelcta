//
//  NewWatchlistNameAndGenresView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 11/02/2023.
//

import SwiftUI

struct NewWatchlistNameAndGenresView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = CreateNewWatchlistViewModel()
    @State var newWatchListName: String
    @State private var nextButtonPressed: Bool = false
//    @Binding var isPresented: Bool = false

    var body: some View {
        NavigationView {
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
                            .background(Color.brandWhite)
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
                    Button(Strings.addTitlesButton) {
                        nextButtonPressed = true
                    }
                    .buttonStyle(PrimaryButton())

                    Button(Strings.cancelButtonTitle) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(SecondaryButton())
                }
            }
            .background(Color.brandWhite)
        }
    }

}

extension NewWatchlistNameAndGenresView {
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
        NewWatchlistNameAndGenresView(newWatchListName: "")
    }
}
