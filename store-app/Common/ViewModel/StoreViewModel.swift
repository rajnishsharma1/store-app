//
//  StoreViewMode.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class StoreViewModel {
    @Published var store: DataWrapper<StoreData> = DataWrapper()
    private let storeRepository: StoreRepository = StoreRepository()
    
    func getStoreDetails() async {
        store.isLoading = true
        
        let storeResponse = await storeRepository.getStoreDetails()
        if storeResponse.response != nil {
            store.response = storeResponse.response
        } else {
            store.error = storeResponse.error
        }
        store.isLoading = false
    }
}

