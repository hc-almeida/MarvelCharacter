//
//  FavoritesViewControllerSpy.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import XCTest
@testable import MarvelCharacter

class FavoritesViewControllerMock: FavoritesViewControllerProtocol {
    
    var displayCharactersCalled = false
    var displayErrorCalled = false
    var displayLoadingCalled = false
    
    func displayCharacters(_ data: [Character]) {
        displayCharactersCalled = true
    }
    
    func displayError(type: ErrorBuild.ErrorType) {
        displayErrorCalled = true
    }
    
    func displayLoading() {
        displayLoadingCalled = true
    }
}
