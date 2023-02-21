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
                    Label(Strings.downloadViewTitle, systemImage: Strings.downloadNewSymbolName)
                        .font(.title)
                        .foregroundColor(.brandYellow)
                }
            WatchListsView()
                .tabItem {
                    Label(Strings.watchlisViewtTitle, systemImage: Strings.watchlistSymbolName)
                        .font(.title)
                }
            CatalogView()
                .tabItem {
                    Label(Strings.catalogViewTitle, systemImage: Strings.catalogListSymbolName)
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
//        .foregroundColor(.brandWhite)
        .tabViewStyle(.automatic)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
