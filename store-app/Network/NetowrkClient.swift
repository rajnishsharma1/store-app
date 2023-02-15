//
//  NetowrkClient.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

class NetworkClient {
    static let instance = NetworkClient()
      
    private init() {}
    
    func getCall(url: String) async throws -> Data {
        let url = URL(string: Urls.mockApi)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
