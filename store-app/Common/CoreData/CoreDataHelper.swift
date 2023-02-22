//
//  CoreDataHelper.swift
//  store-app
//
//  Created by Rajnish Sharma on 17/02/23.
//

import Foundation
import UIKit
import CoreData

class CoreDatahelper {
    let mainContext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataStack().mainContext) {
        self.mainContext = mainContext
    }
    
    // MARK: - Create/Write in CoreData
    /// Saving items in CoreData
    func saveInCoreData(storeData: StoreData) async -> Bool {
        let isDeleted = deleteAll()
        if !isDeleted {
            return false
        }
        
        storeData.items.forEach { item in
            let entity = NSEntityDescription.insertNewObject(forEntityName: CoreDataConstants.entityName, into: mainContext)
            
            entity.setValue(item.name, forKey: CoreDataConstants.name)
            entity.setValue(item.price, forKey: CoreDataConstants.price)
            entity.setValue(item.extra, forKey: CoreDataConstants.extra)
            entity.setValue(item.image, forKey: CoreDataConstants.image)
        }
        
        do {
            try mainContext.save()
            // Successfully saved in CoreData
            return true
        } catch _ as NSError {
            // Delete NSManagedObject (reseting the menory)
            mainContext.reset()
            return false
        }
    }
    
    // MARK: - Fetch/Read from CoreData
    /// Fetching items from CoreData
    func fetchFromCoreData() -> StoreData? {
        var store: StoreData
        
        let fetchRequest = NSFetchRequest<StoreDataItem>(entityName: CoreDataConstants.entityName)
        
        // Sorting stored items with name
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescription]
        
        do {
            let storeItems = try mainContext.fetch(fetchRequest) as NSArray
            
            var itemList: [ItemModel] = []
            
            for storeItem in storeItems {
                itemList.append(ItemModel(name: (storeItem  as? StoreDataItem)?.name ?? "",
                price: (storeItem as? StoreDataItem)?.price ?? "",
                extra: (storeItem  as? StoreDataItem)?.extra ?? "",
                image: (storeItem  as? StoreDataItem)?.image ?? ""))
            }
            
            if itemList.count == 0 {
                return nil
            } else {
                store = StoreData(items: itemList)
            }
        } catch {
            return nil
        }
        
        return store
    }
    
    func searchStore(searchedStore: String) -> StoreData {
        var store: StoreData
        let fetchRequest = NSFetchRequest<StoreDataItem>(entityName: CoreDataConstants.entityName)
        
        // Sorting stored items with name
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescription]

        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", argumentArray: [searchedStore])

        do {
            let storeItems = try mainContext.fetch(fetchRequest) as NSArray

            var itemList: [ItemModel] = []

            for storeItem in storeItems {
                itemList.append(ItemModel(name: (storeItem  as? StoreDataItem)?.name ?? "",
                price: (storeItem as? StoreDataItem)?.price ?? "",
                extra: (storeItem  as? StoreDataItem)?.extra ?? "",
                image: (storeItem  as? StoreDataItem)?.image ?? ""))
            }

            if itemList.count > 0 {
                store = StoreData(items: itemList)
            } else {
                store = StoreData(items: [])
            }
        } catch {
            store = StoreData(items: [])
        }
        return store
    }
    
    // MARK: - Delete all from CoreData
    /// Deleting everything in CoreData
    func deleteAll() -> Bool {
        var isDeleted: Bool = false
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataConstants.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            if  CoreDataStack().persistentContainer.persistentStoreDescriptions.first?.type == NSInMemoryStoreType {
                mainContext.reset()
            } else {
                try mainContext.execute(deleteRequest)
            }
            // Delete successful
            isDeleted = true
        } catch _ as NSError {
            // Delete error
            isDeleted = false
        }
        return isDeleted
    }
}
