//
//  CharacterDetailsViewModelTests.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import XCTest
@testable import MarvelCharacter

class CharacterDetailsViewModelTests: XCTestCase {
    
    var viewModel: CharacterDetailsViewModel!
    var mockViewController: CharacterDetailsViewControllerSpy!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        mockViewController = CharacterDetailsViewControllerSpy()
        mockFavoriteManager = MockFavoriteManager()
        
        let character = Character(id: 1, name: "Test Character", description: "Test Description", urlImage: nil)
        viewModel = CharacterDetailsViewModel(character: character)
        viewModel.viewController = mockViewController
    }
    
    override func tearDown() {
        mockViewController = nil
        mockFavoriteManager = nil
        viewModel = nil
    }
    
    func testShowCharacterDetails() {
        viewModel.showCharacterDetails()
        
        XCTAssertEqual(mockViewController.characterData?.id, 1)
        XCTAssertEqual(mockViewController.characterData?.name, "Test Character")
        XCTAssertEqual(mockViewController.characterData?.description, "Test Description")
        XCTAssertFalse(mockViewController.characterData?.isFavorite ?? true)
    }
    
    func testToggleFavorite_RemoveFromFavorite() {
        viewModel.toggleFavorite(id: 1, isFavorite: true)
        viewModel.toggleFavorite(id: 1, isFavorite: false)
        
        XCTAssertFalse(mockFavoriteManager.isFavorite(id: 1))
    }
}
