//
//  CharacterListViewController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 30/04/24.
//

import UIKit

protocol CharacterListViewControllerProtocol: AnyObject {
    func displayCharacters(_ data: [Character])
    func displayCharacterSearch(_ data: [Character])
    func displayError(type: ErrorBuild.ErrorType)
    func reloadCharacters(_ characters: [Character], animated: Bool)
    func displayLoading()
    func proceedToDetails(data: Character)
}

class CharacterListViewController: UIViewController {
    
    // MARK: - Public Method
    
    var customView: CharacterView?
    var characterList: [Character] = []
    var viewModel: CharacterListViewModelProtocol
    private var searchTask: DispatchWorkItem?

    // MARK: - Inits
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.customView = CharacterView()
        self.customView?.delegate = self
        self.view = customView
    }
    
    // MARK: - View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reset()
        viewModel.fetchCharacters()
        segmentedControll()
        setupSearchBar()
    }
    
    // MARK: - Methods Private
    
    private func setupSearchBar() {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barStyle = .default
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.6)])
        searchController.searchBar.searchTextField.leftView?.tintColor = .black
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    private func segmentedControll() {
        let sections = ["Characters", "Favorites"]
        
        let segmentedControl = UISegmentedControl(items: sections)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .black
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        self.navigationItem.titleView = segmentedControl
    }

    @objc
    func indexChanged(_ segmentedControl: UISegmentedControl) {
        guard let section = CharacterListSection(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        viewModel.section = section
        viewModel.fetchCharactersList()
        print(section)
    }
}

// MARK: - CharacterListViewControllerProtocol

extension CharacterListViewController: CharacterListViewControllerProtocol {
  
    func reloadCharacters(_ characters: [Character], animated: Bool) {
        customView?.reloadCharacters(characters, animated: animated)
    }
    
    func displayCharacterSearch(_ data: [Character]) {
        stopLoading()
        customView?.configure(with: data)
    }
    
    func displayLoading() {
        startLoading()
    }
    
    func displayCharacters(_ data: [Character]) {
        stopLoading()
        customView?.configure(with: data)
    }
    
    func proceedToDetails(data: Character) {
        let viewModel = CharacterDetailsViewModel(character: data)
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        viewModel.viewController = viewController
        present(viewController, animated: true)
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func displayError(type: ErrorBuild.ErrorType) {
        stopLoading()
        let onClose: () -> Void = { [weak self] in
            self?.dismiss(animated: true) {
                self?.viewModel.fetchCharacters()
            }
        }
        
        DispatchQueue.main.async {
            let controller = ErrorBuild.setup(type: type, closeAction: onClose)
            self.present(controller, animated: true)
        }
    }
}

// MARK: - CharacterViewDelegate

extension CharacterListViewController: CharacterViewDelegate {
  
    func didTapCharacter(at index: Int) {
        viewModel.selectCharacter(index: index)
    }

    func fetchCharacterNextPage() {
        viewModel.fetchCharacterNextPage()
    }
}

// MARK: - UISearchResultsUpdating

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        
        searchTask?.cancel()
        
        let newSearchTask = DispatchWorkItem { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.reset()
                self?.viewModel.searchCharacter(with: searchText)
            }
        }
        
        searchTask = newSearchTask
        
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + 0.8,
            execute: newSearchTask)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reset()
        viewModel.fetchCharacters()
    }
}
