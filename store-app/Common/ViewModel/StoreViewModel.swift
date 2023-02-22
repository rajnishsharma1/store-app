//
//  StoreViewMode.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class StoreViewModel {
    
    static let instance: StoreViewModel = StoreViewModel()
    
    private init() {}
    
    /// Published Variable
    @Published var store: DataWrapper<StoreData> = DataWrapper()
    private var masterStore: DataWrapper<StoreData> = DataWrapper()
    private var searchedString: String = ""
    private let storeRepository: StoreRepository = StoreRepository()
    
    /// Setting DataWrapper from API
    func getStoreDetails() async {
        store.isLoading = true
        
        // Call the api, and also update the core data if success
        let storeResponse = await storeRepository.getStoreDetails()
        
        // If User has some value in search, will call search function
        if (!searchedString.isEmpty && storeResponse.response != nil) {
            searchStore(searchedStore: searchedString)
            return
        }
        
        if storeResponse.response != nil {
            store.response = storeResponse.response
            masterStore.response = storeResponse.response
        } else {
            store.error = storeResponse.error
            masterStore.error = storeResponse.error
        }
        store.isLoading = false
    }
    
    // MARK: - Search store
    /// Searching for a store from CoreData
    func searchStore(searchedStore: String) {
        if (searchedStore != "") {
            if (searchedStore.count > 3) {
                // Adding a deboune of 0.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    searchedString = searchedStore
                    store.isLoading = true
                    
                    let storeResponse = storeRepository.searchStore(searchedStore: searchedStore)
                    if storeResponse.response != nil {
                        store.response = storeResponse.response
                    } else {
                        store.response = nil
                        store.error = storeResponse.error
                    }
                    store.isLoading = false
                }
            }
        } else {
            resetSearch()
        }
        
    }
    
    // MARK: - Reset seach
    /// Reset search by setting the original copy of store
    private func resetSearch() {
        store.response = masterStore.response
        store.error = nil
        searchedString = ""
    }
}

