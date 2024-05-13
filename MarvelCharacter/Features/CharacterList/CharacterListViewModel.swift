//
//  CharacterListViewModel.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

protocol CharacterListViewModelProtocol {
    var characters: [Character] { get }
    func reset()
    func fetchCharacters()
    func fetchCharacterNextPage()
    func searchCharacter(with name: String)
    func selectCharacter(index: Int)
    func reloadCharacters(animated: Bool)
    func isFavorite(id: Int) -> Bool
    func toggleFavorite(id: Int, isFavorite: Bool)
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
    weak var viewController: CharacterListViewControllerProtocol?

    // MARK: - Init
    
    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
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
        viewController?.proceedToDetails(data: character)
    }
    
    func isFavorite(id: Int) -> Bool {
        FavoriteManager.shared.isFavorite(id: Int64(id))
    }
    
    func toggleFavorite(id: Int, isFavorite: Bool) {
        guard let index = characters.firstIndex(where: { $0.id == id }) else { return }
        characters[index].isFavorite = isFavorite
        
        if isFavorite {
            addToFavorites(id: id, isFavorite: isFavorite)
        } else {
            removeFromFavorites(id: id)
        }
    }
            
    func reset() {
        currentPage = 0
        totalCount = 0
        characters = []
        searchText = ""
        isSearching = false
        reloadCharacters(animated: true)
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
    
    private func addToFavorites(id: Int, isFavorite: Bool) {
        guard var character = characters.first(where: { $0.id == id }) else { return }
        FavoriteManager.shared.addToFavorites(
            id: Int64(character.id),
            imagePath: character.thumbnail?.url,
            name: character.name,
            text: character.description
        )
    }

    private func removeFromFavorites(id: Int) {
        FavoriteManager.shared.removeFromFavorites(id: Int64(id))
    }
}
