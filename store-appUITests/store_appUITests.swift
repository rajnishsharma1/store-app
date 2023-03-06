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
        let tabBar = XCUIApplication().tabBars["Tab Bar"]

        
        // What (Expected valye)
        let expectedNumberOfTabButtons = 5
        
        // Then (Matching the performed operation final value with expected value)
        XCTAssertEqual(tabBar.buttons.count, expectedNumberOfTabButtons)
    }
    
    func test_popover_is_visible() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        
        
        let filterButton = XCUIApplication().buttons["Filter"]
        filterButton.tap()

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                                    
        XCTAssertTrue(popoverdismissregionElement.exists)
    }
    
    func test_coming_soon_visibility() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.children(matching: .button).element(boundBy: 1).tap()
        tabBar.children(matching: .button).element(boundBy: 2).tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let comingSoonStaticText = elementsQuery.staticTexts["Coming soon..."]
        
        XCTAssertTrue(comingSoonStaticText.exists)
    }
    
    func test_popover_is_hidden() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        
        XCUIDevice.shared.orientation = .portrait

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      
                                    
        XCTAssertFalse(popoverdismissregionElement.exists)
    }
    
    func test_filter_label_existence() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        
        let filterLabel = app.buttons["Filter"]
        XCTAssertTrue(filterLabel.exists)
    }
    
    func test_Explore_label_existence() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        
        let exploreLabel = app.staticTexts.element(matching: .any, identifier: "Explore")
        XCTAssertTrue(exploreLabel.exists)
    }
    
    // Verify Collection View is visible after swiping
    func test_collection_view_is_visible_on_swipe() {
        let app = XCUIApplication()
        // Launch the app
        app.launch()
        let collectionView = app.collectionViews["MainCollectionView"]
        let tableView = app.tables["MainTableView"]
        let _ = tableView.waitForExistence(timeout: 10)
        
        tableView.swipeLeft()
        
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5))
        
        if collectionView.cells.count > 0 {
            XCTAssertTrue(collectionView.cells["Item 1"].exists)
        }
        
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
