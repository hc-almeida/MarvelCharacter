//
//  FavoritesViewController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject {
    func displayCharacters(_ data: [Character])
    func displayError(type: ErrorBuild.ErrorType)
    func displayLoading()
}

class FavoritesViewController: UIViewController {
    
    // MARK: - Public Method
    
    var customView: FavoritesView?
    var characterList: [Character] = []
    var viewModel: FavoritesViewModelProtocol
    private var searchTask: DispatchWorkItem?

    // MARK: - Inits
    
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.customView = FavoritesView()
        self.customView?.delegate = self
        self.view = customView
    }
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
}

// MARK: - CharacterListViewControllerProtocol

extension FavoritesViewController: FavoritesViewControllerProtocol {
   
    func displayCharacters(_ data: [Character]) {
        stopLoading()
        customView?.configure(data)
    }
    
    func displayLoading() {
        startLoading()
    }
    
    func displayError(type: ErrorBuild.ErrorType) {
        stopLoading()
        let onClose: () -> Void = { [weak self] in
            self?.dismiss(animated: true) {
                self?.viewModel.fetchFavorites()
            }
        }
        
        DispatchQueue.main.async {
            let controller = ErrorBuild.setup(type: type, closeAction: onClose)
            self.present(controller, animated: true)
        }
    }
}

// MARK: - CharacterViewDelegate

extension FavoritesViewController: FavoritesViewDelegate {
   
    func didTapFavorite(at id: Int, value: Bool) {
        viewModel.removeFromFavorites(id: id, isFavorite: value)
    }
    
    func isFavorite(id: Int) -> Bool {
        viewModel.isFavorite(id: id)
    }
}
