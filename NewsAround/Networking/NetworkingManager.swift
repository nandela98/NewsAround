//
//  NetworkingManager.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation

protocol NetworkingManagerProtocol {
    static func makeRequest<S: Codable>(session: URLSession, request: URLRequest, model: S.Type, onCompletion: @escaping(S?, NetworkError?) -> ())
    static func makeGetRequest<T: Codable> (path: String, queries: Parameters, onCompletion: @escaping(T?, NetworkError?) -> ())
}


enum NetworkingManager: NetworkingManagerProtocol {
    case getAPI(path: String, data: Parameters)
    
    static var baseURL: URL = URL(string: "http://api.mediastack.com/")!
    
    private var path: String {
        switch self {
        case .getAPI(let path, _):
            return path
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getAPI:
            return .get
        }
    }
    
    
    // MARK:- functions
    fileprivate func addHeaders(request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    fileprivate func asURLRequest() -> URLRequest {
        /// appends the path passed to either of the enum case with the base URL
        var request = URLRequest(url: Self.baseURL.appendingPathComponent(path))
        /// appends the httpMethod based on the enum case
        request.httpMethod = method.rawValue
        var parameters = Parameters()
        switch self {
        case .getAPI(_, let queries):
            /// we are just going through all the key and value pairs in the queries and adding the same to parameters.. For Each Key-Value pair,  parameters[key] = value
            queries.forEach({parameters[$0] = $1})
            /// encode the queries for GET call //
            URLEncoding.queryString.encode(&request, with: parameters)
            self.addHeaders(request: &request)
            return request
        }
    }
    
    /// This function calls the URLRequest passed to it, maps the result and returns it. It is called by GET and POST.
    internal static func makeRequest<S: Codable>(session: URLSession, request: URLRequest, model: S.Type, onCompletion: @escaping(S?, NetworkError?) -> ()) {
        session.dataTask(with: request) { data, response, error in
            guard error == nil, let responseData = data else { onCompletion(nil, NetworkError.apiFailure) ; return }
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    as? Parameters  {
                    let jsonData = try JSONSerialization.data(withJSONObject: json)
                    let response = try JSONDecoder().decode(S.self, from: jsonData)
                    DispatchQueue.main.async {
                        onCompletion(response, nil)
                        return
                    }
                }else {
                    DispatchQueue.main.async {
                        onCompletion(nil,  NetworkError.invalidResponse)
                        return
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    onCompletion(nil, NetworkError.decodingError)
                    return
                }
            }
        }.resume()
    }
    
    /// Generic GET Request
    internal static func makeGetRequest<T: Codable> (path: String, queries: Parameters, onCompletion: @escaping(T?, NetworkError?) -> ()) {
        let session = URLSession.shared
        let request: URLRequest = Self.getAPI(path: path, data: queries).asURLRequest()
        debugPrint(request.url ?? nil)
        makeRequest(session: session, request: request, model: T.self) { (result, error) in
            onCompletion(result, error)
        }
    }

}

