//
//  CharacterView.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 30/04/24.
//

import Foundation
import UIKit

protocol CharacterViewDelegate: AnyObject {
    func fetchCharacterNextPage()
    func didTapCharacter(at index: Int)
    func didTapFavorite(at id: Int, value: Bool)
    func isFavorite(id: Int) -> Bool
}

final class CharacterView: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var emptyListView: EmptyAgentView = {
        let view = EmptyAgentView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.sectionInset = .init(top: 32, left: 0, bottom: 16, right: 0)
        viewLayout.itemSize = .init(width: (UIScreen.main.bounds.width - 35) / 2, height: 300)
        viewLayout.minimumInteritemSpacing = 6
        viewLayout.minimumLineSpacing = 16

        let element = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.showsVerticalScrollIndicator = false
        element.delegate = self
        element.dataSource = self
        return element
    }()
    
    // MARK: - Public Properties
    
    var characterList: [Character] = []
    weak var delegate: CharacterViewDelegate?
    
    // MARK: - Private Properties
    
    private var isFirsCharactersLoad: Bool = true
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with characters: [Character]) {
        isFirsCharactersLoad = false
        
        var indexPaths: [IndexPath] = []
        
        for index in characters.indices {
            let item = IndexPath(item: index + (characterList.count), section: 0)
            indexPaths.append(item)
        }
        
        characterList.append(contentsOf: characters)
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: indexPaths)
        })
        
        setCollectionHidden(characterList.isEmpty)
    }
    
    func reloadCharacters(_ characters: [Character], animated: Bool) {
        characterList = characters
        
        if animated {
            collectionView.reloadData()
        }
    }
    
    private func setCollectionHidden(_ hidden: Bool) {
        emptyListView.isHidden = !hidden
        collectionView.isHidden = hidden
    }
}

// MARK: - ViewCoding

extension CharacterView: ViewCoding {
  
    func setupHierarchy() {
        addSubview(emptyListView)
        addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            emptyListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            emptyListView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyListView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .white
        emptyListView.isHidden = true
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension CharacterView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if !isFirsCharactersLoad && characterList.isEmpty {
//            collectionView.setupEmptyView()
//        } else {
//            collectionView.removeBackGroundView()
//        }

        return characterList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        var isFavorite = false
        
        if let value = delegate?.isFavorite(id: characterList[indexPath.row].id) {
            isFavorite = value
        }

        cell.configureCell(with: characterList[indexPath.row], isFavorite: isFavorite)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapCharacter(at: indexPath.item)
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let lastRowIndex = collectionView.numberOfItems(
            inSection: indexPath.section) - 1
        
        if lastRowIndex == indexPath.row {
            delegate?.fetchCharacterNextPage()
        }
        
        cell.alpha = 0.0
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.4, delay: 0.0, options: .allowUserInteraction, animations: {
            cell.alpha = 1.0
            cell.transform = .identity
        })
    }
}

// MARK: - CharacterCellDelegate

extension CharacterView: CharacterCellDelegate {

    func didTapFavorite(at id: Int, value: Bool) {
        delegate?.didTapFavorite(at: id, value: value)
    }
}
