//
//  HomeViewModelProtocolStub.swift
//  NewsAroundTests
//
//  Created by Sanjeeva Reddy Nandela on 8/7/22.
//

import XCTest
@testable import NewsAround

class HomeViewModelProtocolStub: HomeViewModelProtocol {
    
    var updateViewOnSuccessCalled = false
    func updateViewOnSuccess() {
        updateViewOnSuccessCalled = true
    }
    
    var updateViewOnFailureCalled = false
    func updateViewOnFailure(_ error: NetworkError?) {
        updateViewOnFailureCalled = true
    }
   
}
