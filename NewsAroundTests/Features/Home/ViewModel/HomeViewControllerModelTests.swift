//
//  HomeViewControllerModelTests.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import XCTest
@testable import NewsAround

class HomeViewControllerModelTests: XCTestCase {

    var viewModel: HomeDataModelProtocol!
    var service  : NewsAPIServiceProtocol!
    
    override func setUp() {
        service = NewsAPIService()
        viewModel = HomeViewControllerModel(service: service)
    }
    
    func test_fetchNews() {
        viewModel.fetchNewsData()
    }

    override func tearDown() {
        viewModel = nil
    }

}
