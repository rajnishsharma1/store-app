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
    let viewModel: StoreViewModel = StoreViewModel()
    let networkClient: NetworkClient = NetworkClient.instance

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
    
    func test_repository_search() {
        let result = storeRepository.searchStore(searchedStore: "Item 1")
        
        XCTAssertNotNil(result)
        
        XCTAssertEqual(result.response?.items.count, 1)
    }
    
    func test_getter_setter_for_search_string() {
        viewModel.searchedStringValue = "Test String"
        
        XCTAssertEqual(viewModel.searchedStringValue, "Test String")
    }
    
    func test_network_api_call() async {
        let result = await networkClient.makeApiCall(url: "https://run.mocky.io/v3/995ce2a0-1daf-4993-915f-8c198f3f752c")
        
        XCTAssertNotNil(result)
    }
    
    func test_network_api_call_result_total_count() async {
        let result = await networkClient.makeApiCall(url: "https://run.mocky.io/v3/995ce2a0-1daf-4993-915f-8c198f3f752c")
        
        let decodedResult = try? JSONDecoder().decode(StoreModel.self, from: result!)
        XCTAssertEqual(decodedResult?.data.items.count, 9)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
