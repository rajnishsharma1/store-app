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
    static let instance = CoreDatahelper()
    
    private init () {}
    
    // MARK: Save in Core Data -
    func saveInCoreData(storeData: StoreData) async -> Bool {
        let isDeleted = await deleteAll()
        if !isDeleted {
            return false
        }
        
        
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = await appDelegate.persistentContainer.viewContext
        
        storeData.items.forEach { item in
            
            guard let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: managedContext) else {
                return
            }
            
            // Create NSManagedObject
            let storeDataItem = NSManagedObject(entity: entity, insertInto: managedContext)
            storeDataItem.setValue(item.name, forKey: CoreDataConstants.name)
            storeDataItem.setValue(item.price, forKey: CoreDataConstants.price)
            storeDataItem.setValue(item.extra, forKey: CoreDataConstants.extra)
            storeDataItem.setValue(item.image, forKey: CoreDataConstants.image)
        }
        
        do {
            try managedContext.save()
            // Successfully saved in CoreData
            return true
        } catch _ as NSError {
            // Delete NSManagedObject
            managedContext.reset()
            return false
        }
    }
    
    // MARK: Fetch from Core Data -
    func fetchFromCoreData() async -> StoreData? {
        var store: StoreData
        
        guard let appDelegate =
            await UIApplication.shared.delegate as? AppDelegate else {
              return nil
          }
          
          let managedContext = await appDelegate.persistentContainer.viewContext
          
          let fetchRequest = NSFetchRequest<StoreDataItem>(entityName: CoreDataConstants.entityName)
        
          do {
              var storeItems = try managedContext.fetch(fetchRequest)
              storeItems = storeItems.sorted { a, b in
                  a.name ?? "" < b.name ?? ""
              }
              var itemList: [ItemModel] = []
              for storeItem in storeItems {
                  itemList.append(ItemModel(name: storeItem.name ?? "", price: storeItem.price ?? "", extra: storeItem.extra, image: storeItem.image))
              }
              store = StoreData(items: itemList)
          } catch {
              return nil
          }
        
        return store
    }
    
    // MARK: Delete all from Core Data -
    func deleteAll() async -> Bool {
        var isDeleted: Bool = false
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = await appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CoreDataConstants.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            // Delete successful
            try managedContext.execute(deleteRequest)
            isDeleted = true
        } catch let error as NSError {
            // Delete error
            isDeleted = false
            print("Cannot delete CoreData Entities: \(error) \(error.description)")
        }
        return isDeleted
    }
}
