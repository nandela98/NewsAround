//
//  NewsAPIService.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation


protocol NewsAPIServiceProtocol {
    func fetchNews(currentPage: Int, onCompletion: @escaping(NewsResponse?, NetworkError?) -> ())
}

final class NewsAPIService: NewsAPIServiceProtocol {
    
    func fetchNews(currentPage: Int, onCompletion: @escaping (NewsResponse?, NetworkError?) -> ()) {
        NetworkingManager.makeGetRequest(path: Constants.Url.path, queries: buildQueryParams(currentPage: currentPage)) { (result: NewsResponse?, error)  in
            if let _ = error {
                onCompletion(nil, error)
            }else {
                onCompletion(result, nil)
            }
        }
    }
    
    private func buildQueryParams(currentPage: Int) -> [String : Any] {
        let queryParams = ["access_key": Constants.Auth.key,
                           "countries": NewsCountry.ind.rawValue,
                           "languages": NewsLanguage.en,
                           "limit":10,
                           "offset": currentPage] as [String : Any]
        return queryParams
    }
    
}
