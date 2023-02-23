//
//  MainTabView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 29/01/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DownloadNewMoviesView()
                .tabItem {
                    Label(Strings.downloadViewTitle, systemImage: Strings.downloadNewSFName)
                        .font(.title)
                        .foregroundColor(.brandYellow)
                }
            WatchListsView()
                .tabItem {
                    Label(Strings.watchlisViewtTitle, systemImage: Strings.watchlistSFName)
                        .font(.title)
                }
            CatalogView()
                .tabItem {
                    Label(Strings.catalogViewTitle, systemImage: Strings.catalogListSFName)
                        .font(.title)
                }
        }
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = .brandYellow
            UITabBar.appearance().barTintColor = .brandDarkBlue
            UITabBar.appearance().backgroundColor = .brandDarkBlue
            UITabBar.appearance().tintColor = .brandDarkBlue
        }
        .tint(.brandOrange)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
