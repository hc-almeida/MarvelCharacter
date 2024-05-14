//
//  CharacterListViewModelTests.swift
//  MarvelCharacterTests
//
//  Created by Hellen Caroline  on 13/05/24.
//

import XCTest
@testable import MarvelCharacter

class CharacterListViewModelTests: XCTestCase {
    
    var viewModel: CharacterListViewModel!
    var mockService: CharacterListServiceSpy!
    var mockViewController: CharacterListViewControllerSpy!
    
    override func setUp() {
        mockService = CharacterListServiceSpy()
        mockViewController = CharacterListViewControllerSpy()
        viewModel = CharacterListViewModel(service: mockService)
        viewModel.viewController = mockViewController
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockViewController = nil
    }
    
    func testFetchCharacters_Success() {
        mockService.expectedResult = .success(.fixture())
        viewModel.fetchCharacters()
        
        XCTAssertTrue(mockViewController.displayLoadingCalled)
        XCTAssertTrue(mockService.fetchCharacterListCalled)
        XCTAssertEqual(viewModel.characters, [Character.fixture()])
    }
    
    func testFetchCharacters_Failure() {
        mockService.expectedResult = .failure(.unownedError)
        viewModel.fetchCharacters()
        
        XCTAssert(mockViewController.displayErrorCalled)
        XCTAssertNotEqual(viewModel.characters, [Character.fixture()])
    }
    
    func testFetchCharacters_Failure_NoConnection() {
        mockService.expectedResult = .failure(.errorConnection)
        viewModel.fetchCharacters()

        XCTAssert(mockViewController.displayErrorCalled)
        XCTAssertNotEqual(viewModel.characters, [Character.fixture()])
    }
    
    func testSearchCharacter_Success() {
        mockService.expectedResult = .success(.fixture())
        viewModel.searchCharacter(with: "3-D Man")
        
        XCTAssertTrue(mockViewController.displayLoadingCalled)
        XCTAssertTrue(mockService.fetchSearchCharacterCalled)
        XCTAssertEqual(viewModel.characters, [Character.fixture()])
    }
    
    func testFetchCharacterNextPage() {
        mockService.expectedResult = .success(.fixture())
        viewModel.fetchCharacterNextPage()
        
        XCTAssertTrue(mockViewController.displayLoadingCalled)
        XCTAssertTrue(mockService.fetchCharacterListCalled)
    }
    
    func testselectCharacter() {
        let characters = [Character(id: 1, name: "Character 1", description: ""),
                          Character(id: 2, name: "Character 2", description: ""),
                          Character(id: 3, name: "Character 3", description: "")]
       
        viewModel.characters = characters
        viewModel.selectCharacter(index: 1)
        
        XCTAssertTrue(mockViewController.proceedToDetailsCalled)
    }    
}
