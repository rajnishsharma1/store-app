//
//  StoreViewMode.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class StoreViewModel {
    @Published var store: DataWrapper<StoreData> = DataWrapper()
    private let apiService: MockApiService = MockApiService()

    func getStoreDetails() async throws {
        store.isLoading = true
        let storeResponse = try await apiService.getStoreData()
        store.response = storeResponse.data
        
        let saved = await CoreDatahelper.instance.saveInCoreData(storeModel: storeResponse)
        
        store.isLoading = false
    }
}

