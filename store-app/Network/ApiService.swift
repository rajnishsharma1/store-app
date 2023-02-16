//
//  ApiService.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class ApiService {
    
    /// Api Service for the store API
    func getStoreData() async throws -> StoreModel {
        let data = try await NetworkClient.instance.makeApiCall(url: Urls.storeApi)
        let result = try JSONDecoder().decode(StoreModel.self, from: data)
        print(result.data.items)
        return result
    }
}

