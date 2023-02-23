//
//  NewWatchListAddTitlesView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 21/02/2023.
//

import SwiftUI

struct NewWatchListAddTitlesView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Title.title, ascending: true)],animation: .default)
    private var titles: FetchedResults<Title>

    var body: some View {
        List(titles) { title in
            
        }
    }
}

extension NewWatchListAddTitlesView {
    @MainActor class NewWatchlistNameAndGenresViewModel: ObservableObject {
        @Published private(set) var selectedTitles = [Title]()


    }
}
struct CreateNewWatchListAddTitlesView_Previews: PreviewProvider {
    static var previews: some View {
        NewWatchListAddTitlesView()
    }
}
