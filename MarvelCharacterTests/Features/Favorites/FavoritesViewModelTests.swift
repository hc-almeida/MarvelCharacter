//
//  FavoritesViewModelTests.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import XCTest
@testable import MarvelCharacter

class FavoritesViewModelTests: XCTestCase {
    
    var sut: FavoritesViewModel!
    var mockViewController: FavoritesViewControllerMock!
    var mockFavoriteManager: MockFavoriteManager!
    
    override func setUp() {
        mockViewController = FavoritesViewControllerMock()
        mockFavoriteManager = MockFavoriteManager()
        
        sut = FavoritesViewModel()
        sut.viewController = mockViewController
    }

    override func tearDown() {
        mockViewController = nil
        mockFavoriteManager = nil
        sut = nil
    }

    func testFetchFavorites() {
        let characters = [Character.fixture(),
                          Character.fixture()]
        sut.characters = characters
        mockFavoriteManager.mockCharacters = characters

        sut.fetchFavorites()
        mockFavoriteManager.getFavoritesCalled = true

        XCTAssertTrue(mockViewController.displayLoadingCalled)
        XCTAssertTrue(mockFavoriteManager.getFavoritesCalled)
        XCTAssertTrue(mockViewController.displayCharactersCalled)
    }
}
