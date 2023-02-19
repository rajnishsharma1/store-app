//
//  NetowrkClient.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class NetworkClient {
    // Instance for the singleton NetworkClient
    static let instance = NetworkClient()
      
    // making default constructor private
    private init() {}
    
    func makeApiCall(url: String) async -> Data? {
        let url = URL(string: url)!
        do {
            // Making API call for the [url]
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            // Sending nil if there is a error in API call
            return nil
        }
    }
}
