//
//  store_coreDataTests.swift
//  store-appTests
//
//  Created by Rajnish Sharma on 18/02/23.
//

import XCTest
import CoreData
@testable import store_app

class store_coreDataTests: XCTestCase {
    var coreDataHelper: CoreDatahelper!
    var coreDataStack: CoreDataTestStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        coreDataHelper = CoreDatahelper(mainContext: coreDataStack.mainContext)
    }
    
    func test_create_data() async {
        let isSaved: Bool = await coreDataHelper.saveInCoreData(storeData: StoreData(items: [ItemModel(name: "Item 9", price: "₹ 190", extra: "Same day shipping", image: "https://imgstatic.phonepe.com/images/dark/app-icons-ia-1/transfers/80/80/ic_check_balance.png")]))
        
        XCTAssertTrue(isSaved)
    }
    
    func test_fetch_data() {
        let result = coreDataHelper.fetchFromCoreData()
        
        XCTAssertEqual(result?.items.count, 1)
    }
}
