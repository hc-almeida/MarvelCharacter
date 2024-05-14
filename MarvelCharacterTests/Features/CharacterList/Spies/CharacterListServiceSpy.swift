//
//  CharacterListServiceSpy.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import Foundation
@testable import MarvelCharacter

class CharacterListServiceSpy: CharacterListServiceProtocol {

    var fetchCharacterListCalled = false
    var fetchSearchCharacterCalled = false
    var expectedResult: Result<CharacterData, NetworkError>?
    
    func fetchCharacterList(offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void) {
        fetchCharacterListCalled = true
        
        if let result = expectedResult {
            completion(result)
        }
    }
    
    func fetchSearchCharacter(name: String, offset: Int, completion: @escaping (Result<CharacterData, NetworkError>) -> Void) {
        fetchSearchCharacterCalled = true
       
        if let result = expectedResult {
            completion(result)
        }
    }
}
