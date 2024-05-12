//
//  ShareButton.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 10/05/24.
//

import UIKit

class ShareButton: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var contentView: UICircularView = {
        let circularView = UICircularView(frame: .zero)
        circularView.backgroundColor = .white
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(.share7, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Functions
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        button.addTarget(target, action: action, for: controlEvents)
    }
}

// MARK: - ViewCoding

extension ShareButton: ViewCoding {
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupConfigurations() {
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}

