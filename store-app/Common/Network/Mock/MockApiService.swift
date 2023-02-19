//
//  MockApiService.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation

class MockApiService {
    
    /// Api Service to mock the store data response
    func getStoreData() async throws -> StoreModel {
        return StoreModel(status: "Success",
                          error: nil,
                          data: StoreData(
                            items: [
                                ItemModel(name: "Item 1", price: "₹ 100", extra: "Same day shipping", image: ""),
                                ItemModel(name: "Item 2", price: "₹ 400", extra: "Same day shipping", image: ""),
                                ItemModel(name: "Item 3", price: "₹ 100", extra: nil, image: ""),
                                ItemModel(name: "Item 4", price: "₹ 80", extra: nil, image: ""),
                                ItemModel(name: "Item 5", price: "₹ 190", extra: nil, image: ""),
                                ItemModel(name: "Item 6", price: "₹ 70", extra: nil, image: ""),
                                ItemModel(name: "Item 7", price: "₹ 190", extra: nil, image: ""),
                                ItemModel(name: "Item 8", price: "₹ 190", extra: nil, image: ""),
                                ItemModel(name: "Item 9", price: "₹ 190", extra: nil, image: ""),
                                ItemModel(name: "Item 10", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 11", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 12", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 13", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 14", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 15", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 16", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 17", price: "₹ 200", extra: nil, image: ""),
                                ItemModel(name: "Item 18", price: "₹ 200", extra: nil, image: "")
                            ]
                        )
        )
    }
}
