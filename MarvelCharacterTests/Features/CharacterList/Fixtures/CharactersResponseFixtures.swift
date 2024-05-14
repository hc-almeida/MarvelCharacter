//
//  CharactersResponseFixtures.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import Foundation
@testable import MarvelCharacter

extension CharacterResponse {
    static func fixture(
        code: Int = 0,
        status: String = "",
        data: CharacterData = .fixture()
    ) -> CharacterResponse {
        return CharacterResponse(code: code, status: status, data: data)
    }
}

extension CharacterData {
    static func fixture(
        offset: Int = 0,
        limit: Int = 20,
        total: Int = 1564,
        count: Int = 20,
        results: [Character] = [.fixture()]
    ) -> CharacterData {
        return CharacterData(offset: offset, limit: limit, total: total, count: count, results: results)
    }
}

extension Character {
    static func fixture(
        id: Int = 1011334,
        name: String = "3-D Man",
        description: String = "",
        thumbnail: CharacterImage? = nil,
        urlImage: String? = nil,
        isFavorite: Bool? = false
    ) -> Character {
        return Character(id: id, name: name, description: description, thumbnail: thumbnail, urlImage: urlImage, isFavorite: isFavorite)
    }
}

extension CharacterImage {
    static func fixture(path: String? = nil, extension ext: String? = nil) -> CharacterImage {
        return CharacterImage(path: path, extension: ext)
    }
}
