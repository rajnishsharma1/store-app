//
//  StoreRepository.swift
//  store-app
//
//  Created by Rajnish Sharma on 17/02/23.
//

import Foundation

class StoreRepository {
    private let apiService: ApiService = ApiService()
    
    // MARK: - Store Detail Data
    /// Retuning Data to ViewModel
    ///
    /// It can either be data from API
    ///  or It can be from CoreData
    ///
    ///  When API is success - Save the response in local data and show in UI
    ///  When API fails - Show data from CoreData
    func getStoreDetails() async -> DataWrapper<StoreData> {
        var store: DataWrapper<StoreData> = DataWrapper()
        
        // API response for store data
        let storeResponse = await apiService.getStoreData()
        
        if storeResponse == nil { // If API error
            let storeLocalData = CoreDatahelper().fetchFromCoreData()
            if storeLocalData == nil {
                store.error = Strings.errorMessage
            } else {
                store.response = storeLocalData!
            }
        } else { // If API success
            store.response = storeResponse!.data
            // Storing API response to CoreData
            let _ = await CoreDatahelper().saveInCoreData(storeData: storeResponse!.data)
        }
        return store
    }
}
