//
//  CharacterListViewModel.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

protocol CharacterListViewModelProtocol {
    var characters: [Character] { get }
    var section: CharacterListSection { get set }
    func reset()
    func fetchCharacters()
    func fetchCharactersList()
    func fetchCharacterNextPage()
    func searchCharacter(with name: String)
    func selectCharacter(index: Int)
}

class CharacterListViewModel: CharacterListViewModelProtocol {

    // MARK: - Proprietes
    
    private var searchText = ""
    private var totalCount = 0
    private var currentPage = 0
    private let pageCount = 20
    private let service: CharacterListServiceProtocol
    
    var isSearching: Bool = false
    var characters = [Character]()
    var section: CharacterListSection = .characters
    weak var viewController: CharacterListViewControllerProtocol?

    // MARK: - Init
    
    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func fetchCharactersList() {
        switch section {
        case .favorites: 
            fetchFavorites()
        case .characters:
            fetchCharacters()
        }
    }
    
    func fetchCharacterNextPage() {
        guard shouldFetchNewPage() else { return }
        currentPage += 1
        
        isSearching
        ? searchCharacter()
        : fetchCharacters()
    }
    
    func searchCharacter(with name: String) {
        viewController?.displayLoading()
        searchText = name.capitalized
        searchCharacter()
    }
    
    func reloadCharacters(animated: Bool) {
        viewController?.reloadCharacters(characters, animated: animated)
    }
    
    func selectCharacter(index: Int) {
        let character = characters[index]
//        let character = DataModel[index]
        viewController?.proceedToDetails(data: character)
    }
    
    func reset() {
        currentPage = 0
        totalCount = 0
        characters = []
        searchText = ""
        isSearching = false
        reloadCharacters(animated: true)
    }
    
    func fetchFavorites() {
        characters = []
        
        characters.append(contentsOf: characters)
        viewController?.displayCharacters(characters)
    }
    
    func fetchCharacters() {
        viewController?.displayLoading()
        
        service.fetchCharacterList(offset: currentPage * pageCount) { [weak self] result in
            switch result {
            case .success(let response):
                self?.totalCount = response.total
                let characters = response.results
                self?.characters.append(contentsOf: characters)
                self?.viewController?.displayCharacters(characters)
            case .failure(let failure):
                self?.presentError(error: failure)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func searchCharacter() {
        service.fetchSearchCharacter(name: searchText, offset: currentPage * pageCount) { [weak self] result in
            switch result {
            case .success(let response):
                self?.totalCount = response.total
                let characters = response.results
                self?.characters.append(contentsOf: characters)
                self?.viewController?.displayCharacters(characters)
            case .failure(let failure):
                self?.presentError(error: failure)
            }
        }
    }
    
    private func shouldFetchNewPage() -> Bool {
        let isFirstFetch = totalCount == 0
        let shouldFetchMore = (currentPage + 1) * pageCount < totalCount
        
        return isFirstFetch || shouldFetchMore
    }
    
    private func presentError(error: NetworkError) {
        if error == .errorConnection {
            self.viewController?.displayError(type: .noConnection)
        } else {
            self.viewController?.displayError(type: .generic)
        }
    }
}
