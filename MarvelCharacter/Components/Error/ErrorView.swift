//
//  ErrorView.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 07/05/24.
//

import Foundation
import UIKit

final class ErrorView: UIView {
    
    // MARK: - UI
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleText, subtitleText])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var middleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Private Propertie
    
    private let data: ErrorViewData
    
    // MARK: - Public Propertie
    
    var didTapCloseAction: (() -> Void)?
    
    // MARK: - Inits
    
    init(data: ErrorViewData) {
        self.data = data
        super.init(frame: .zero)
        setupView()
        setupData()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    
    private func setupData() {
        titleText.text = data.title
        subtitleText.text = data.subtitle
        imageView.image = data.image
        backgroundColor = .white
    }
    
    // MARK: - Public Method
    
    @objc func didTapClose() {
        didTapCloseAction?()
    }
    
}

// MARK: - ViewCoding

extension ErrorView: ViewCoding {
  
    func setupHierarchy() {
        addSubview(closeButton)
        addSubview(textStackView)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            
            textStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 24),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
