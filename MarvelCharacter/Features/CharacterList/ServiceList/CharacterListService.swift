//
//  CharacterListService.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

protocol CharacterListServiceProtocol {
    func fetchCharacterList(offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void)
    func fetchSearchCharacter(name: String, offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void)
}

final class CharacterListService: CharacterListServiceProtocol {
    
    // MARK: - Private Properties
    
    private let service: NetworkManagerProtocol
    
    init(service: NetworkManagerProtocol = NetworkManager()) {
        self.service = service
    }
    
    func fetchCharacterList(offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void) {
        let request = MarvelCharacterRequest(offset: offset)
        
        service.request(request) { (result: Result<CharacterResponse, NetworkError>) in
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    guard let characters = response.data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    completion(.success(characters))
                    
                }
          
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchSearchCharacter(name: String, offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void) {
        let request = MarvelCharacterRequest(offset: offset, nameStartsWith: name)
        print(":::: request 2 \(request)")
        
        service.request(request) { (result: Result<CharacterResponse, NetworkError>) in
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    guard let characters = response.data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    completion(.success(characters))
                    
                }
          
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
