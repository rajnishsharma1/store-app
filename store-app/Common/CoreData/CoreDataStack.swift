//
//  CoreDataStack.swift
//  store-app
//
//  Created by Rajnish Sharma on 19/02/23.
//

import Foundation
import CoreData

/// CoreDataStack
class CoreDataStack {
    /// Persistent Container
    var persistentContainer: NSPersistentContainer
    /// MainContext to work on the main thread
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: CoreDataConstants.storeContainer)
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
    }
}
