//
//  FavoriteManagerSpy.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import Foundation
@testable import MarvelCharacter

class MockFavoriteManager: FavoriteManagerProtocol {
   
    var favorites: Set<Int64> = []
    var mockCharacters: [Character] = []
    var mockIsFavorite: Bool = false
    var isFavoriteCalled: Bool = false
    var removeFromFavoritesCalled: Bool = false
    
    var getFavoritesCalled: Bool = false
    
    func getFavorites() -> [Character] {
        getFavoritesCalled = true
        return mockCharacters
    }
    
    func isFavorite(id: Int64) -> Bool {
        isFavoriteCalled = true
        return mockIsFavorite
    }
    
    func removeFromFavorites(id: Int64) {
        removeFromFavoritesCalled = true
        favorites.remove(id)
    }
    
    func addToFavorites(id: Int64, imagePath: String?, name: String?, text: String?) {
        favorites.insert(id)
    }
}
