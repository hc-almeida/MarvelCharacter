//
//  CharacterDetailsViewModel.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 10/05/24.
//

import Foundation

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var character: Character? { get }
    func showCharacterDetails()
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
    
    
    
    
}
