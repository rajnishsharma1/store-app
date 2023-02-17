//
//  StoreRepository.swift
//  store-app
//
//  Created by Rajnish Sharma on 17/02/23.
//

import Foundation

class StoreRepository {
    private let apiService: ApiService = ApiService()
    
    func getStoreDetails() async -> DataWrapper<StoreData> {
        var store: DataWrapper<StoreData> = DataWrapper()
        
        // API response for store data
        let storeResponse = await apiService.getStoreData()
        
        if storeResponse == nil { // If API error
            let storeLocalData = await CoreDatahelper.instance.fetchFromCoreData()
            
            if storeLocalData == nil {
                store.error = Strings.errorMessage
            } else {
                store.response = storeLocalData!
            }
        } else { // If API success
            store.response = storeResponse!.data
            // Storing API response to CoreData
            let isSavedInCoreData = await CoreDatahelper.instance.saveInCoreData(storeData: storeResponse!.data)
            
            if !isSavedInCoreData {
                // Handle if data is not stored
            }
        }
        return store
    }
}
