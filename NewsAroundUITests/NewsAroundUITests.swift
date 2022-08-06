//
//  NewsAroundUITests.swift
//  NewsAroundUITests
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import XCTest
@testable import NewsAround

class NewsAroundUITests: XCTestCase {
    
    let app = XCUIApplication()
    var newsNavigationBar: XCUIElement!
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
        newsNavigationBar = app.navigationBars["News"]
    }
    
    func test_navBarSearchTapAndInputs() {
        let searchField = newsNavigationBar.searchFields["Search"]
        searchField.tap()
        
        let cancelButton = newsNavigationBar.buttons["Cancel"]
        cancelButton.tap()
        
        searchField.tap()
        searchField.typeText("Elon")
        searchField.buttons["Clear text"].tap()
        cancelButton.tap()
    }
    
    func test_tableViewSwipeUp() {
        app.children(matching: .window).element(boundBy: 0).swipeUp()
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
