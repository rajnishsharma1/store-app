//
//  store_appTests.swift
//  store-appTests
//
//  Created by Rajnish Sharma on 13/02/23.
//

import XCTest
@testable import store_app

final class store_appTests: XCTestCase {
    
    let storeRepository: StoreRepository = StoreRepository()
    let apiService: ApiService = ApiService()

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
    
    func test_repository_response_count() async {
        let result = await storeRepository.getStoreDetails()
        
        XCTAssertTrue(result.response?.items.count ?? 0 >= 1)
    }
    
    func test_repository_response_for_nil() async {
        let result = await storeRepository.getStoreDetails()
        
        XCTAssertNotNil(result.response?.items)
    }
    
    func test_repository_response_for_error() async {
        let result = await storeRepository.getStoreDetails()
        
        XCTAssertTrue(result.error == nil)
    }
    
    func test_api_response_for_nil() async {
        let result = await apiService.getStoreData()
        
        XCTAssertNotNil(result)
    }
    
    func test_api_response_for_error() async {
        let result = await apiService.getStoreData()
        
        XCTAssertTrue(result != nil && result?.error == nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
