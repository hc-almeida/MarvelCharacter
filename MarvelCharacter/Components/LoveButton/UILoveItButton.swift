//
//  UILoveItButton.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 01/05/24.
//

import UIKit

class UILoveItButton: UIView {
    
    // MARK: - User Interface Components
    
    private lazy var contentView: UICircularView = {
        let circularView = UICircularView(frame: .zero)
        circularView.backgroundColor = .white
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    private lazy var heartButton: UIHeartButton = {
        let button = UIHeartButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public Properties
    
    var isFilled: Bool {
        get {
            heartButton.isFilled
        }
        set {
            heartButton.isFilled = newValue
        }
    }
    
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
    
    func toggleIt() {
        heartButton.toggleIt()
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        heartButton.addTarget(target, action: action, for: controlEvents)
    }
}

// MARK: - ViewCoding

extension UILoveItButton: ViewCoding {
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(heartButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heartButton.topAnchor.constraint(equalTo: topAnchor),
            heartButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            heartButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupConfigurations() {
        heartButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
}
