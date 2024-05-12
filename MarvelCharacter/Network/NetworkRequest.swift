//
//  NetworkRequest.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

protocol NetworkRequest {
    var endpoint: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
}

extension NetworkRequest {
  
    func asURLRequest() -> URLRequest? {

        var components = URLComponents(string: endpoint)!
        
        components.queryItems = (parameters ?? [:]).map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        print(":::: request \(request)")
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
