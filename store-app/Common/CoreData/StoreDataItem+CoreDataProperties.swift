//
//  StoreDataItem+CoreDataProperties.swift
//  store-app
//
//  Created by Rajnish Sharma on 17/02/23.
//
//

import Foundation
import CoreData

extension StoreDataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreDataItem> {
        return NSFetchRequest<StoreDataItem>(entityName: "StoreDataItem")
    }

    @NSManaged public var itemName: NSObject?
    @NSManaged public var itemPrice: NSObject?
    @NSManaged public var image: NSObject?
    @NSManaged public var extra: NSObject?

}

extension StoreDataItem : Identifiable {

}
