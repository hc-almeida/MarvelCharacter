//
//  CharacterDetailsViewController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 10/05/24.
//

import Foundation
import UIKit

protocol CharacterDetailsViewControllerProtocol: AnyObject {
    func displayCharacter(data: Character)
}

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Public Method
    
    var customView: CharacterDetails?
    var viewModel: CharacterDetailsViewModelProtocol

    // MARK: - Inits
    
    init(viewModel: CharacterDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.customView = CharacterDetails()
        self.customView?.delegate = self
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showCharacterDetails()
    }
}

// MARK: - CharacterDetailsViewControllerProtocol

extension CharacterDetailsViewController: CharacterDetailsViewControllerProtocol {
    
    func displayCharacter(data: Character) {
        customView?.configure(with: data)
    }
}

// MARK: - CharacterDetailsDelegate

extension CharacterDetailsViewController: CharacterDetailsDelegate {
   
    func shareImage(of character: UIImage?) {
        print("teste \(character)")
        
        let items = [character]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)

    }
}