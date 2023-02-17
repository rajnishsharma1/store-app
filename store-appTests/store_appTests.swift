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
    
    func testBlackColorHexWithRGB() {
        let hexCode = "#000000"
        let color = AppUtils.hexStringToUIColor(hex: hexCode, alpha: 1)
        
        XCTAssertEqual(color, UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
    }
    
    func testWhiteColorHexWithRGB() {
        let hexCode = "#FFFFFF"
        let color = AppUtils.hexStringToUIColor(hex: hexCode, alpha: 1)
        
        XCTAssertEqual(color, UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1))
    }
    
    func testRedColorHexWithRGB() {
        let hexCode = "#ff0000"
        let color = AppUtils.hexStringToUIColor(hex: hexCode, alpha: 1)
        
        XCTAssertEqual(color, UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1))
    }
}
