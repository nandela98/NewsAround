//
//  NewsAPIServiceTests.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import XCTest
@testable import NewsAround

class NewsAPIServiceTests: XCTestCase {
    
    var service: NewsAPIServiceProtocol!
    
    override func setUp() {
        service = NewsAPIService()
    }

    override func tearDown() {
        service = nil
    }
    
    func test_fetchingNewsData() {
        let expectation = self.expectation(description: "fetch news data should return NewsResponse model")
        service.fetchNews(currentPage: 0) { model, _ in
            if let newsResponse = model, type(of: newsResponse) == NewsResponse.self {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
