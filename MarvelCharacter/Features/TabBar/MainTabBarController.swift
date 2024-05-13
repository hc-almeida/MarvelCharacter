//
//  MainTabBarController.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let service = CharacterListService()
        let characterVM = CharacterListViewModel(service: service)
        let characterVC = CharacterListViewController(viewModel: characterVM)
        characterVM.viewController = characterVC
        
        let favoritesVM = FavoritesViewModel()
        let favoritesVC = FavoritesViewController(viewModel: favoritesVM)
        favoritesVM.viewController = favoritesVC

        characterVC.title = "Character"
        favoritesVC.title = "Favorites"
        
        let home = MainNavigationController(rootViewController: characterVC)
        let favorites = MainNavigationController(rootViewController: favoritesVC)
        
        self.setViewControllers([home, favorites], animated: true)
        guard let items = self.tabBar.items else { return }
        let images = [UIImage(systemName: "house.fill"), UIImage(systemName: "star.fill")]
        
        for (item, image) in zip(items, images) {
            item.image = image
        }
        
        self.tabBar.tintColor = .systemRed
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}
