//
//  CoreDataTestStack.swift
//  store-app
//
//  Created by Rajnish Sharma on 19/02/23.
//

import Foundation
import CoreData
@testable import store_app

class CoreDataTestStack: CoreDataStack {
    
    override init() {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: CoreDataConstants.storeContainer
        )
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if (error as NSError?) != nil {
                fatalError("Unresolved Error")
            }
        }
       CoreDataStack().persistentContainer = container
    }
}
