//
//  CatalogView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 10/02/2023.
//

import SwiftUI

struct CatalogView: View {
//    @StateObject var viewModel = CatalogViewModel()

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Title.title, ascending: true)],animation: .default)
    private var titles: FetchedResults<Title>

    private var uniqueTitles: [Title] {
        var result = [Title]()
        var uniqueTitleNames = [String]()

        for title in titles {
            if let id = title.id, !uniqueTitleNames.contains(id) {
                uniqueTitleNames.append(id)
                result.append(title)
            }
        }

        return titles.shuffled()
    }

    var body: some View {
        NavigationStack {
            VStack {
                List(uniqueTitles) { title in
                    SingleTitleView(title: title)

                }
                .navigationTitle(Strings.catalogViewTitle)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.brandLightBlue, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(Color.brandLightBlue)
                .padding(2)
            }
        }

    }
}

extension CatalogView {
    @MainActor public class CatalogViewModel: ObservableObject {
        @Published private(set) var downloadedImages: [String : Image] = [:]

        public func downloadImage(titleId: String, urlString: String) {
            guard let url = URL(string: urlString), urlString.contains("https://") else { return }

            downloadedImages[titleId] = Image(Strings.imageDownloadErrorSFName).data(url: url)
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
