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
   
    init(name: String, price: String, extra: String?) {
        self.name = name
        self.price = price
        self.extra = extra
    }
    
    enum CodingKeys: String, CodingKey {
      case name
      case price
      case extra
    }
}
