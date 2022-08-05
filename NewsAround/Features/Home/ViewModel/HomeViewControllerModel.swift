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
}

final class HomeViewControllerModel: HomeDataModelProtocol {

    var news          : NewsResponse?
    var currentPage   : Int = 0 {
        didSet {
            fetchNewsData()
        }
    }
    weak var delegate: HomeViewModelProtocol?
    var isLoadingList : Bool = false
    
    func fetchNewsData() {
        isLoadingList = true
        NetworkingManager.makeGetRequest(path: "v1/news", queries: ["access_key" : "203456028f8657ddae1de51b4912fc52", "offset":currentPage, "limit":10, "countries": NewsCountry.ind.rawValue, "languages": NewsLanguage.en]) { [weak self] (result: NewsResponse?, error)  in
            if let newsResponse = result, let articles = newsResponse.data {
                self?.news = newsResponse
                self?.news?.data! += articles
                self?.delegate?.updateViewOnSuccess()
            }else {
                self?.delegate?.updateViewOnFailure(error)
            }
        }
    }

    
}
