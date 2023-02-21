//
//  MuviSelctaApp.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import SwiftUI

@main
struct MuviSelctaApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, PersistenceController.shared.persistentContainer.viewContext)
        }
    }
}
