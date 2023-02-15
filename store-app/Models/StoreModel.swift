//
//  StoreModel.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct StoreModel: Codable {
    /// Status returned by the API
    let status: String
    
    /// Error thrown by the API
    let error: String?
    
    /// List of items in the store
    let data: StoreData
}
