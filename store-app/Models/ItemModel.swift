//
//  ItemModel.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct ItemModel {
    let name: String
    let price: String
    let extra: String
    
    init(name: String, price: String, extra: String) {
        self.name = name
        self.price = price
        self.extra = extra
    }
    
}
