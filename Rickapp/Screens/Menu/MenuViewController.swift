//
//  MenuViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit

class MenuViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarNavigationBar()
    }
    
    private func setupControllers() {

        let characterListViewController = CharacterListViewController()
        let characterListViewModel = CharacterListViewModel()
        characterListViewController.viewModel = characterListViewModel
        characterListViewController.tabBarItem = UITabBarItem(title: "All", image: UIImage.getImage(.characterListIcon).withRenderingMode(.alwaysTemplate), tag: 0)

        let favouriteListViewController = FavouriteListViewController()
        let favouriteListViewModel = FavouriteListViewModel()
        favouriteListViewController.viewModel = favouriteListViewModel
        favouriteListViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage.getImage(.heartIconUnselected).withRenderingMode(.alwaysTemplate), tag: 1)
        
        self.viewControllers = [characterListViewController, favouriteListViewController]
    }

    private func configureTabBarNavigationBar() {
        tabBar.barTintColor = .backgroundGray
        tabBar.tintColor = .white
    }
}



