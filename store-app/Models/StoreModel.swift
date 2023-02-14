//
//  StoreModel.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct StoreModel {
    /// Status returned by the API
    let status: String
    
    /// Error thrown by the API
    let error: String?
    
    /// List of items in the store
    let item: [ItemModel]
    
    init(status: String, error: String?, item: [ItemModel]) {
        self.status = status
        self.error = error
        self.item = item
    }
}
