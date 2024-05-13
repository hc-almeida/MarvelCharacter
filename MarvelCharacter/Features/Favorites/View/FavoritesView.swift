//
//  FavoritesView.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import Foundation
import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func isFavorite(id: Int) -> Bool
    func didTapFavorite(at id: Int, value: Bool)
}

final class FavoritesView: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .init(top: 32, left: 0, bottom: 16, right: 0)
        viewLayout.itemSize = .init(width: (UIScreen.main.bounds.width - 60) / 2, height: 250)
        viewLayout.minimumInteritemSpacing = 16
        viewLayout.minimumLineSpacing = 50

        let element = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.showsVerticalScrollIndicator = false
        element.delegate = self
        element.dataSource = self
        return element
    }()

    // MARK: - Public Properties
    
    weak var delegate: FavoritesViewDelegate?
    
    // MARK: - Private Properties
    
    private var favoriteCharacters: [Character] = []
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(_ viewModel: [Character]) {
        favoriteCharacters = viewModel
        collectionView.reloadData()
    }
}

// MARK: - ViewCoding

extension FavoritesView: ViewCoding {
    
    func setupHierarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .white
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FavoritesView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteCharacters.isEmpty
            ? collectionView.setupEmptyView()
            : collectionView.removeBackGroundView()
        
        return favoriteCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        var isFavorite = false
        
        if let value = delegate?.isFavorite(id: favoriteCharacters[indexPath.row].id) {
            isFavorite = value
        }
        
        cell.configureCell(with: favoriteCharacters[indexPath.row], isFavorite: isFavorite)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - CharacterCellDelegate

extension FavoritesView: CharacterCellDelegate {

    func didTapFavorite(at id: Int, value: Bool) {
        delegate?.didTapFavorite(at: id, value: value)
    }
}
