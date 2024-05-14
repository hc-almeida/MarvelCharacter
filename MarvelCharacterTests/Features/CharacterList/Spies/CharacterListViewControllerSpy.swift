//
//  CharacterListViewControllerSpy.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import Foundation
@testable import MarvelCharacter

class CharacterListViewControllerSpy: CharacterListViewControllerProtocol {
   
    var displayCharactersCalled = false
    var displayCharacterSearchCalled = false
    var displayErrorCalled = false
    var reloadCharactersCalled = false
    var proceedToDetailsCalled = false
    var displayLoadingCalled = false
    
    func displayCharacters(_ data: [Character]) {
        displayCharactersCalled = true
    }
    
    func displayCharacterSearch(_ data: [Character]) {
        displayCharacterSearchCalled = true
    }
    
    func displayError(type: ErrorBuild.ErrorType) {
        displayErrorCalled = true
    }
    
    func reloadCharacters(_ characters: [Character], animated: Bool) {
        reloadCharactersCalled = true
    }
    
    func proceedToDetails(data: Character) {
        proceedToDetailsCalled = true
    }
    
    func displayLoading() {
        displayLoadingCalled = true
    }
}
