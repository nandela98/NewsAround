//
//  NewsAPIServiceProtocolStub.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import XCTest
@testable import NewsAround

class NewsAPIServiceProtocolStub: NewsAPIServiceProtocol {
    
    var serviceFailed = false
    
    func fetchNews(currentPage: Int, onCompletion: @escaping (NewsResponse?, NetworkError?) -> ()) {
//        if let _ = error {
//            serviceFailed = true
//        }else {
//            serviceFailed = false
//        }
    }
        
}
