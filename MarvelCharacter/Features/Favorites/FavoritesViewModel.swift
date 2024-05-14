//
//  FavoritesViewModel.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var characters: [Character] { get }
    func fetchFavorites()
    func isFavorite(id: Int) -> Bool
    func removeFromFavorites(id: Int, isFavorite: Bool)
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    
    var characters = [Character]()
    weak var viewController: FavoritesViewControllerProtocol?
    
    // MARK: - Init
    
    func fetchFavorites() {
        viewController?.displayLoading()
        characters = FavoriteManager.shared.getFavorites()
        viewController?.displayCharacters(characters)
    }
    
    func isFavorite(id: Int) -> Bool {
        FavoriteManager.shared.isFavorite(id: Int64(id))
    }
    
    func removeFromFavorites(id: Int, isFavorite: Bool) {
        guard let index = characters.firstIndex(where: { $0.id == id }) else { return }
        characters[index].isFavorite = isFavorite
        
        FavoriteManager.shared.removeFromFavorites(id: Int64(id))
        fetchFavorites()
    }
}
