//
//  MuviSelctaApp.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import SwiftUI

@main
struct MuviSelctaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
