//
//  ItemModel.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct ItemModel : Codable {
    /// Name of the item
    let name: String
    
    /// Price of the item
    let price: String
    
    /// Additional details about the item
    let extra: String?
    
    /// Item image URL
    let image: String?
}
