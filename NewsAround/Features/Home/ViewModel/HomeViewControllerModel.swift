//
//  HomeViewControllerModel.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func updateViewOnSuccess()
    func updateViewOnFailure(_ error: NetworkError?)
}

protocol HomeDataModelProtocol {
    func fetchNewsData()
    var news: NewsResponse? { get set }
    var currentPage : Int { get set }
    var delegate: HomeViewModelProtocol? { get set }
    var isLoadingList : Bool { get set }
    var service: NewsAPIServiceProtocol { get set }
}

final class HomeViewControllerModel: HomeDataModelProtocol {
    
    var service: NewsAPIServiceProtocol
    var news          : NewsResponse?
    var currentPage   : Int = 0 {
        didSet {
            fetchNewsData()
        }
    }
    weak var delegate: HomeViewModelProtocol?
    var isLoadingList : Bool = false
    
    init(service: NewsAPIServiceProtocol = NewsAPIService()) {
        self.service = service
    }
    
    func fetchNewsData() {
        isLoadingList = true
        service.fetchNews(currentPage: currentPage) { [weak self] result, error in
            if let newsResponse = result, let articles = newsResponse.data {
                self?.appendToArrayOnPagination(newsResponse, articles)
                self?.delegate?.updateViewOnSuccess()
            }else {
                self?.delegate?.updateViewOnFailure(error)
            }
        }
    }
    
}

// MARK: append to array logic

fileprivate extension HomeViewControllerModel {
    
    func appendToArrayOnPagination(_ newsResponse: NewsResponse, _ articles: [Article]) {
        if self.currentPage >= 1 {
            self.news?.pagination = newsResponse.pagination
            self.news?.data! += articles
        }else {
            self.news = newsResponse
        }
    }
    
}


