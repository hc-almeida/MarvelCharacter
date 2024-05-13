//
//  MainNavigationController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white

        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance
    }
}
