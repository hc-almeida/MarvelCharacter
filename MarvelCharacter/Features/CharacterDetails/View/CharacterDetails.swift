//
//  CharacterDetails.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 10/05/24.
//

import Foundation
import UIKit

protocol CharacterDetailsDelegate: AnyObject {
    func shareImage(of character: UIImage?)
    func didTapFavorite(at id: Int, value: Bool)
}

final class CharacterDetails: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(red: 13/255, green: 25/255, blue: 33/255)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingHead
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loveItButton: UILoveItButton = {
        let button = UILoveItButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLoveItButton), for: .touchUpInside)
        return button
    }()
    
    var shareButton: ShareButton = {
        let button = ShareButton()
        button.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public Properties
    
    var imageShare: UIImage?
    var character: Character?
    weak var delegate: CharacterDetailsDelegate?
    
    // MARK: - Inits
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with data: Character) {
        character = data
        thumbnail.addImageFromURL(url: data.thumbnail?.url ?? "")
        name.text = data.name
        loveItButton.isFilled = data.isFavorite ?? false
      
        if data.description.isEmpty {
            characterDescription.text = "Não há descrição oficial"
            return
        }
        
        characterDescription.text = data.description
    }
    
    // MARK: - Private Methods
    
    @objc 
    private func didTapShare() {
        delegate?.shareImage(of: thumbnail.image)
    }
    
    @objc 
    private func didTapLoveItButton() {
        loveItButton.toggleIt()
        let value = loveItButton.isFilled
        delegate?.didTapFavorite(at: character?.id ?? 0, value: value)
    }
}

// MARK: - ViewCoding

extension CharacterDetails: ViewCoding {
    
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbnail)
        contentView.addSubview(name)
        contentView.addSubview(characterDescription)
        contentView.addSubview(loveItButton)
        contentView.addSubview(shareButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            thumbnail.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnail.heightAnchor.constraint(equalToConstant: 500),
            
            name.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            name.trailingAnchor.constraint(equalTo: loveItButton.leadingAnchor, constant: -24),
            
            characterDescription.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24),
            characterDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            characterDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            characterDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36),
            
            loveItButton.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 16),
            loveItButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -16),
            loveItButton.heightAnchor.constraint(equalToConstant: 30),
            loveItButton.widthAnchor.constraint(equalToConstant: 30),
            
            shareButton.topAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupConfigurations() {
        backgroundColor = .white
    }
}
