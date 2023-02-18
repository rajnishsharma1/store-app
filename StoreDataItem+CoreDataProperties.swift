//
//  StoreDataItem+CoreDataProperties.swift
//  store-app
//
//  Created by Rajnish Sharma on 18/02/23.
//
//

import Foundation
import CoreData


extension StoreDataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoreDataItem> {
        return NSFetchRequest<StoreDataItem>(entityName: "StoreDataItem")
    }

    @NSManaged public var extra: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?

}

extension StoreDataItem : Identifiable {

}
