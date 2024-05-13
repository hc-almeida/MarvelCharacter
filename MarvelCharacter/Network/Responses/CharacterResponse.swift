//
//  CharacterResponse.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

struct CharacterResponse: Decodable {
    let code: Int?
    let status: String?
    let data: CharacterData?
}

struct CharacterData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Equatable {
    
    var id: Int
    let name: String
    let description: String
    var thumbnail: CharacterImage? = nil
    var urlImage: String? = nil
    var isFavorite: Bool? = false
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

struct CharacterImage: Decodable {
    let path: String?
    let `extension`: String?
}

extension CharacterImage {
    
    var url: String? {
        if let path = path, let ext = `extension` {
            return "\(path).\(ext)"
        } else {
            return nil
        }
    }
}
