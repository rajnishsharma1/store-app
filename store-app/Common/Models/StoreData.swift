//
//  StoreData.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct StoreData: Codable {
    /// List of items in the store
    let items: [ItemModel]
}
