//
//  CharacterCell.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 01/05/24.
//

import Foundation
import UIKit

protocol CharacterCellDelegate: AnyObject {
    func didTapFavorite(at id: Int, value: Bool)
}

class CharacterCell: UICollectionViewCell {
    
    // MARK: - User Interface Components
    
    private lazy var containerView: UIView = {
        let cardView = UICardView()
        cardView.backgroundColor = .white
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private lazy var cardImage: UIView = {
        let cardImage = UICardView()
        cardImage.clipsToBounds = true
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        return cardImage
    }()
    
    private lazy var blurImage: UIImageView = {
        let blurImage = UIImageView()
        blurImage.backgroundColor = .systemGray
        blurImage.addBlurToView(style: .light)
        blurImage.translatesAutoresizingMaskIntoConstraints = false
        return blurImage
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        image.backgroundColor = .systemGroupedBackground
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cardName: UIView = {
        let cardName = UIView()
        cardName.addBlurToView(style: .systemChromeMaterialDark)
        cardName.translatesAutoresizingMaskIntoConstraints = false
        return cardName
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.lineBreakMode = .byTruncatingHead
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loveItButton: UILoveItButton = {
        let button = UILoveItButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLoveItButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties
    
    var characterId: Int = 0
    weak var delegate: CharacterCellDelegate?
    static let identifier = String(describing: CharacterCell.self)
    
    // MARK: - Inits
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    override func prepareForReuse() {
        clear()
    }
    
    // MARK: - Public Methods
    
    func configureCell(with data: Character, isFavorite: Bool) {
        name.text = data.name
        characterId = data.id
        loveItButton.isFilled = isFavorite
        let url = data.thumbnail?.url ?? data.urlImage
        image.addImageFromURL(url: url ?? .empty)
        blurImage.addImageFromURL(url: url ?? .empty)
    }
    
    // MARK: - Private Methods
    
    @objc
    func didTapLoveItButton() {
        loveItButton.toggleIt()
        let value = loveItButton.isFilled
        delegate?.didTapFavorite(at: characterId, value: value)
    }
    
    private func clear() {
        blurImage.image = nil
        image.image = nil
        name.text = nil
        loveItButton.isFilled = false
    }
}

// MARK: - ViewCoding

extension CharacterCell: ViewCoding {
 
    func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubview(blurImage)
        blurImage.addSubview(image)
        blurImage.addSubview(cardName)
        cardName.addSubview(name)
        containerView.addSubview(loveItButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            image.topAnchor.constraint(equalTo: blurImage.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: blurImage.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: blurImage.trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: blurImage.bottomAnchor, constant: -60),
            
            cardName.leadingAnchor.constraint(equalTo: blurImage.leadingAnchor),
            cardName.trailingAnchor.constraint(equalTo: blurImage.trailingAnchor),
            cardName.bottomAnchor.constraint(equalTo: blurImage.bottomAnchor),
            cardName.heightAnchor.constraint(equalToConstant: 50),
            
            name.centerYAnchor.constraint(equalTo: cardName.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: cardName.leadingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: cardName.trailingAnchor, constant: -8),
            name.bottomAnchor.constraint(equalTo: cardName.bottomAnchor, constant: -2),
            
            loveItButton.widthAnchor.constraint(equalToConstant: 25),
            loveItButton.heightAnchor.constraint(equalToConstant: 25),
            loveItButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
            loveItButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -35)
        ])
        
    }
    
    func setupConfigurations() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
