//
//  NewsDisplayCellTests.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import XCTest
@testable import NewsAround

class NewsDisplayCellTests: XCTestCase {

    var newsDisplayCell: NewsDisplayCell!

    override func setUp() {
        newsDisplayCell = NewsDisplayCell(style: .default, reuseIdentifier: "cell")
    }
    
    func test_newsDataSetup() {
        newsDisplayCell.item = Article(title: "Headline",
                                       description: "Corona Virus")
        XCTAssertTrue(newsDisplayCell.textLabel?.text == "Headline")
    }
    
    func test_newsDataSetupWithNullValues() {
        newsDisplayCell.item = Article(title: nil,
                                       description: nil)
        XCTAssertTrue(newsDisplayCell.detailTextLabel?.text == "NA")
    }
    
    func test_initWithDecoder() {
        let cell = NewsDisplayCell(coder: NSCoder())
        XCTAssertNil(cell)
    }

    override func tearDown() {
        newsDisplayCell = nil
    }
    
}
