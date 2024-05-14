//
//  CharacterDetailsViewControllerSpy.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import Foundation
@testable import MarvelCharacter

class CharacterDetailsViewControllerSpy: CharacterDetailsViewControllerProtocol {
   
    var displayCharacterCalled = false
    var characterData: Character?
    
    func displayCharacter(data: MarvelCharacter.Character) {
        displayCharacterCalled = true
        characterData = data
    }
}
