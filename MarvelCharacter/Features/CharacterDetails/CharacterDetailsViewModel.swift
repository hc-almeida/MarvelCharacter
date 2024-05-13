//
//  CharacterDetailsViewModel.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 10/05/24.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var character: Character? { get }
    func showCharacterDetails()
    func toggleFavorite(id: Int, isFavorite: Bool)
}


final class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    var character: Character?
    weak var viewController: CharacterDetailsViewControllerProtocol?
    
    // MARK: - Init
    
    init(character: Character) {
        self.character = character
    }
    
    func showCharacterDetails() {
        guard let character = character else { return }
        viewController?.displayCharacter(data: character)
    }
    
    func toggleFavorite(id: Int, isFavorite: Bool) {
        character?.isFavorite = isFavorite
        
        if isFavorite {
            addToFavorites(id: id, isFavorite: isFavorite)
        } else {
            removeFromFavorites(id: id)
        }
    }
    
    private func addToFavorites(id: Int, isFavorite: Bool) {
        if let character = character,
           character.id == id {
            FavoriteManager.shared.addToFavorites(
                id: Int64(character.id),
                imagePath: character.thumbnail?.url,
                name: character.name,
                text: character.description
            )
        }
    }

    private func removeFromFavorites(id: Int) {
        FavoriteManager.shared.removeFromFavorites(id: Int64(id))
    }
}
