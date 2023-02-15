//
//  StoreViewMode.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

@Published var store: DataWrapper<StoreModel> = DataWrapper()
    let apiService = ApiService()

    func getStoreDetails() async throws {
        store.isLoading = true
  
        let storeResponse = try await apiService.getStoreData()
        store.response = storeResponse
        print("API Success")
 
        
        store.isLoading = false
        
    }
