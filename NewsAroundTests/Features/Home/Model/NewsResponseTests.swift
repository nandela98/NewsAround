//
//  NewsResponseTests.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import XCTest
@testable import NewsAround

class NewsResponseTests: XCTestCase {

    func test_newsResponseMapping() {
        let json = """
             {"pagination":{"limit":1,"offset":0,"count":1,"total":10000},
             "data":[{"author":null,"title":"Elon Musk to lead Twitter temporarily as CEO after $44 bn take over","description":"Musk, the world richest man, is also the CEO at Tesla Inc and heads two other ventures, The Boring Company and SpaceX.","url":"https://www.businesstoday.in/latest/world/story/elon-musk-to-lead-twitter-temporarily-as-ceo-after-44-bn-take-over-332522-2022-05-06?utm_source=rssfeed","source":"Business Today | Latest Stock Market And Economy News India","image":null,"category":"business","language":"en","country":"in","published_at":"2022-05-06T03:10:09+00:00"}]}
        """
        let jsonData = json.data(using: .utf8)!
        let response = try! JSONDecoder().decode(NewsResponse.self, from: jsonData)
        let expectedPagination = response.pagination
        let expectedData = response.data
        XCTAssertNotNil(expectedData?[0].query)
        XCTAssertEqual(expectedData?.count ?? 0, 1)
        XCTAssertEqual(expectedData?[0].title ?? "", "Elon Musk to lead Twitter temporarily as CEO after $44 bn take over")
        XCTAssertEqual(expectedPagination?.count ?? 0, 1)
    }
    
    func test_newsResponseMappingNullTitleData() {
        let json = """
             {"pagination":{"limit":1,"offset":0,"count":1,"total":10000},
             "data":[{"author":null,"title":null,"description":"Musk, the world richest man, is also the CEO at Tesla Inc and heads two other ventures, The Boring Company and SpaceX.","url":"https://www.businesstoday.in/latest/world/story/elon-musk-to-lead-twitter-temporarily-as-ceo-after-44-bn-take-over-332522-2022-05-06?utm_source=rssfeed","source":"Business Today | Latest Stock Market And Economy News India","image":null,"category":"business","language":"en","country":"in","published_at":"2022-05-06T03:10:09+00:00"}]}
        """
        let jsonData = json.data(using: .utf8)!
        let response = try! JSONDecoder().decode(NewsResponse.self, from: jsonData)
        let expectedData = response.data
        XCTAssertNotNil(expectedData?[0].query)
    }


}
