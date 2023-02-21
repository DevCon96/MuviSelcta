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

        return result
    }

    var body: some View {
        VStack {
            Text(Strings.catalogViewTitle)
                .foregroundColor(.brandYellow)
                .font(.title)

            List(uniqueTitles) { title in
                SingleTitleView(title: title)

            }
            .background(Color.brandLightBlue)
        }

    }
}

extension CatalogView {
    @MainActor public class CatalogViewModel: ObservableObject {
        @Environment(\.managedObjectContext) private var viewContext

        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Title.title, ascending: true)],animation: .default)
        private var titles: FetchedResults<Title>
        @Published private(set) var uniqueTitles = [Title]()

        init() {
            filterDuplicates()
        }

        private func filterDuplicates() {
            for title in titles {
                if !uniqueTitles.contains(title) {
                    uniqueTitles.append(title)
                }
            }
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
