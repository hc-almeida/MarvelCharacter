//
//  CoreDataStack.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import CoreData

class CoreDataStack {
    
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext

    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
