//
//  NetworkManager.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

typealias NetworkResult<T: Decodable> = ((Result<T, NetworkError>) -> Void)

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>)
}

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Private Properties
    
    private let urlSession: URLSessionProtocol
    
    // MARK: - Init
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Public Functions
    
    func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) {

        guard let request = request.asURLRequest() else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        urlSession.loadData(with: request) { data, response, error in
            if let error = error {
                if let nsError = error as? NSError, nsError.domain == NSURLErrorDomain {
                    completion(.failure(NetworkError.errorConnection))
                } else {
                    completion(.failure(.unownedError))
                }
                return
            }
      
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if response.statusCode == -1001 || response.statusCode == -1005 || response.statusCode == -1009 {
                completion(.failure(NetworkError.errorConnection))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(NetworkError.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }
    }
}
