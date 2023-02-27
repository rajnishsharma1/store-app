//
//  StoreViewMode.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class StoreViewModel {
    var networkDelegate: NetworkDelegate!
    
    private var masterStore: DataWrapper<StoreData> = DataWrapper()
    private var searchedString: String = ""
    
    var getSearchedString: String {
        get {
            return searchedString
        }
    }
    
    
    private let storeRepository: StoreRepository = StoreRepository()
    
    /// Setting DataWrapper from API
    func getStoreDetails() async {
        networkDelegate.updateChanges(result: DataWrapper(isLoading: true))
        
        // Call the api, and also update the core data if success
        let storeResponse = await storeRepository.getStoreDetails()
        
        // If User has some value in search, will call search function
        if (!searchedString.isEmpty && storeResponse.response != nil) {
            searchStore(searchedStore: searchedString)
            return
        }
        
        if storeResponse.response != nil {
            networkDelegate.updateChanges(result: DataWrapper(response: storeResponse.response))
            masterStore.response = storeResponse.response
        } else {
            networkDelegate.updateChanges(result: DataWrapper(error: storeResponse.error))
            masterStore.error = storeResponse.error
        }
        networkDelegate.updateChanges(result: DataWrapper(isLoading: false))
    }
    
    // MARK: - Search store
    /// Searching for a store from CoreData
    func searchStore(searchedStore: String) {
        if (searchedStore != "") {
            if (searchedStore.count > 3) {
                searchedString = searchedStore
                networkDelegate.updateChanges(result: DataWrapper(isLoading: true))
                
                let storeResponse = storeRepository.searchStore(searchedStore: searchedStore)
                if storeResponse.response != nil {
                    networkDelegate.updateChanges(result: DataWrapper(response: storeResponse.response))
                } else {
                    networkDelegate.updateChanges(result: DataWrapper(response: nil))
                    networkDelegate.updateChanges(result: DataWrapper(error: storeResponse.error))
                }
                networkDelegate.updateChanges(result: DataWrapper(isLoading: false))

            }
        } else {
            resetSearch()
        }
        
    }
    
    // MARK: - Reset seach
    /// Reset search by setting the original copy of store
    private func resetSearch() {
        networkDelegate.updateChanges(result: DataWrapper(response: masterStore.response))
        networkDelegate.updateChanges(result: DataWrapper(error: nil))

        searchedString = ""
    }
}

