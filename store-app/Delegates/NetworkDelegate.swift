//
//  NetworkDelegate.swift
//  store-app
//
//  Created by Rajnish Sharma on 27/02/23.
//

import Foundation

protocol NetworkDelegate {
    func updateChanges(result: DataWrapper<StoreData>)
}
