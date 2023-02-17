//
//  ApiService.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class ApiService {
    
    // MARK:  Service for the store API
    func getStoreData() async -> StoreModel? {
        let data = await NetworkClient.instance.makeApiCall(url: Urls.storeApi)
        
        // API error
        if data == nil {
            return nil
        }
        // API success
        do {
            // Parsing the response using JSONDecoder
            let result = try JSONDecoder().decode(StoreModel.self, from: data!)
            return result
        } catch {
            // Return nil if there is a parsing error
            return nil
        }
        
    }
}

