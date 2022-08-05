//
//  NetworkUtilities.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation

/// Custom Error enum that we'll use in case
enum NetworkError: Error {
    case noInternet
    case apiFailure
    case invalidResponse
    case decodingError
}

/// An enum for various HTTPMethod.
enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
}

/// to provide data to the API Calls
typealias Parameters = [String : Any]

/// for encoding the Query Parameters in case of a GET call. Queries are passed in the ?q=<>&<> format
enum URLEncoding {
    case queryString
    case none
    
    func encode(_ request: inout URLRequest, with parameters: Parameters)  {
        switch self {
        case .queryString:
            guard let url = request.url else { return }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
               !parameters.isEmpty {
                
                urlComponents.queryItems = [URLQueryItem]()
                for (k, v) in parameters {
                    let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
        case .none:
            break
        }
    }
}
