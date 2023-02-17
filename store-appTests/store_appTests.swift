//
//  store_appTests.swift
//  store-appTests
//
//  Created by Rajnish Sharma on 13/02/23.
//

import XCTest
@testable import store_app

final class store_appTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let testString = "Hello World!"
        
        XCTAssertEqual(testString, "Hello World!")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
