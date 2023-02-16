//
//  DataWrapper.swift
//  store-app
//
//  Created by Rajnish Sharma on 14/02/23.
//

import Foundation

struct DataWrapper<T> {
    var response: T?
    var isLoading: Bool = false
    var error: String?
}
