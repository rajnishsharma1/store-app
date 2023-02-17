//
//  store_appUITests.swift
//  store-appUITests
//
//  Created by Rajnish Sharma on 13/02/23.
//

import XCTest

final class store_appUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func test_search_bar_with_some_search_value() {
        let app = XCUIApplication()
        app.launch()
        
        // When (Performed some operation)
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("test string")
        
        // What (Expected valye)
        let expectedTypedValue = "test string"
        
        // Then (Matching the performed operation final value with expected value)
        XCTAssertEqual(searchSearchField.value as! String, expectedTypedValue)
    }
    
    func test_search_bar_delete_chatacters() {
        let app = XCUIApplication()
        app.launch()
        
    
        // Maping delete key from keyboard to a constant value
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let searchSearchField = app.searchFields["Search"]
        
        // When (Performed some operation)
        searchSearchField.tap()
        searchSearchField.typeText("test string")
        
        // Deleting few characters using keyboard
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        
        // What (Expected valye)
        let expectedFinalValue = "test st"
        
        // Then (Matching the performed operation final value with expected value)
        XCTAssertEqual(searchSearchField.value as! String, expectedFinalValue)
    }
    
    func test_count_tab_bar_buttons() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()

        // When (Performed some operation)
        let missionControlButton = app.tabBars["Tab Bar"].buttons["mission control"]
        let table = app.tabBars["Tab Bar"].buttons["table"]
        missionControlButton.tap()
        table.tap()

        
        // What (Expected valye)
        let expectedNumberOfTabButtons = 2
        
        // Then (Matching the performed operation final value with expected value)
        XCTAssertEqual(app.tabBars.buttons.count, expectedNumberOfTabButtons)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
