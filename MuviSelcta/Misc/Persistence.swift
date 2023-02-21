//
//  Persistence.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import CoreData

struct PersistenceController {
    static let entityName = "MuviSelcta"
    static let shared = PersistenceController()

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PersistenceController.entityName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: PersistenceController.entityName)
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    public func addTitle(_ title: Title) {
        let newTitle = Title(context: PersistenceController.shared.persistentContainer.viewContext)
        newTitle.title = title.title
        newTitle.movieLength = Int16(title.movieLength)
        newTitle.year = Int16(title.year)
        newTitle.nextEpisode = title.nextEpisode
        newTitle.numberOfEpisodes = Int16(title.numberOfEpisodes)
        newTitle.seriesEndYear = Int16(title.seriesEndYear)
        newTitle.seriesStartYear = Int16(title.seriesStartYear)
        newTitle.id = title.id
        newTitle.titleType = title.titleType
        newTitle.genre = title.genre

        do {
            try persistentContainer.viewContext.save()
            print("Inserted title into database - \(String(describing: title.title))")
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    public func getTitlesFor(genre: IMDBApi.Genre) -> [Title]? {
        return nil
    }

    /// Rrturns nil if nothing is found or fetched
    public func fetchTitles(titleId: String? = nil, titleName: String? = nil) -> [Title]? {
        var fetchId = ""
        var fetchMatchValue = ""

        if let titleId {
            fetchMatchValue = titleId
            fetchId = "id"
        }
        if let titleName, fetchId.isEmpty {
            fetchId = titleName
        }

        guard !fetchId.isEmpty else { return nil }

        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PersistenceController.entityName)
            fetchRequest.predicate = NSPredicate(format: " %@ = %@ ", fetchId, fetchMatchValue)

            let data = try persistentContainer.viewContext.fetch(fetchRequest) as? [Title]

            return data
        } catch {
            log(.error, "Failed to fetch title - \(error)")
        }

        return nil
    }

    // Clean up Database
    @discardableResult
    private func sanatise() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PersistenceController.entityName)
        var storedTitles = [String: Title]()
        var didSanatise = false

        do {
            var data = try persistentContainer.viewContext.fetch(fetchRequest) as? [Title]
            if let data {
                for title in data {
                    if let alreadyStored = storedTitles[title.id ?? "NIL"] {

                    }
                }
            }
        } catch {
            log(.error, "Failed to fetch any data from CoreData")
        }

        return didSanatise
    }
}
