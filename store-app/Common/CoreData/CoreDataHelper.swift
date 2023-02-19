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
    let backgroundcontext: NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext,
         backgroundContext: NSManagedObjectContext = CoreDataStack.shared.backgroundContext) {
        self.mainContext = mainContext
        self.backgroundcontext = backgroundContext
    }
    
    // MARK: - Save in Core Data
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
    
    // MARK: - Fetch from Core Data
    func fetchFromCoreData() -> StoreData? {
        var store: StoreData
        
        let fetchRequest = NSFetchRequest<StoreDataItem>(entityName: CoreDataConstants.entityName)
        
        do {
            var storeItems = try backgroundcontext.fetch(fetchRequest)
            
            // Sorting stored items with name
            storeItems = storeItems.sorted { a, b in
                a.name ?? "" < b.name ?? ""
            }
            var itemList: [ItemModel] = []
            for storeItem in storeItems {
                itemList.append(ItemModel(name: storeItem.name ?? "", price: storeItem.price ?? "", extra: storeItem.extra, image: storeItem.image))
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
    
    // MARK: - Delete all from Core Data
    func deleteAll() -> Bool {
        var isDeleted: Bool = false
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataConstants.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            // Delete successful
            try backgroundcontext.execute(deleteRequest)
            isDeleted = true
        } catch _ as NSError {
            // Delete error
            isDeleted = false
        }
        return isDeleted
    }
}