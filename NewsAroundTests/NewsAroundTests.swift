//
//  NewsAroundTests.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import XCTest
@testable import NewsAround

class NewsAroundTests: XCTestCase {

    var homeController: HomeViewController!
    
    override func setUp() {
        homeController = HomeViewController()
    }

    override func tearDown() {
        homeController = nil
    }
    
    func test_viewDidLoad() {
        homeController.viewDidLoad()
        XCTAssertNotNil(homeController.view)
    }
    
    func test_handleRefresh() {
        homeController.handleRefresh(UIRefreshControl())
        XCTAssertNotNil(homeController.models)
    }
}
