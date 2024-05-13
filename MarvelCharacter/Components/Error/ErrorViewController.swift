//
//  ErrorViewController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 07/05/24.
//

import Foundation
import UIKit

final class ErrorViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var customView: ErrorView = {
        let view = ErrorView(data: viewData)
        return view
    }()
    
    // MARK: - Private Propertie
    
    private let viewData: ErrorViewData
    
    // MARK: - Public Propertie
    
    var didTapCloseAction: (() -> Void)?
    
    // MARK: - Inits
    
    init(viewData: ErrorViewData) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        customView.didTapCloseAction = { [weak self] in
            self?.didTapCloseAction?()
            
        }
    }
}
