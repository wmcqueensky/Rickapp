//
//  MenuViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit

protocol ScrollableToTop {
    func scrollToTop()
}

class MenuViewController: UITabBarController, UITabBarControllerDelegate {
    private var lastSelectedViewController: UIViewController? = nil
    private var isTabBarDisabled = false
    private let selectionIndicator = UIView()
    private var itemWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupSelectionIndicator()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBarNavigationBar()
    }
    
    private func setupSelectionIndicator() {
        itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        selectionIndicator.backgroundColor = .white
        tabBar.addSubview(selectionIndicator)
        selectionIndicator.frame = CGRect(x: 0, y: 0, width: itemWidth, height: -3)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            let xOrigin = CGFloat(selectedIndex) * itemWidth
            let selectionIndicatorFrame = CGRect(x: xOrigin, y: 0, width: itemWidth, height: -3)
            
            UIView.animate(withDuration: 0.3) {
                self.selectionIndicator.frame = selectionIndicatorFrame
            }
        }
        
        guard let scrollableController = viewController as? ScrollableToTop else { return }
        
        if !isTabBarDisabled, viewController == lastSelectedViewController {
            isTabBarDisabled = true
            scrollableController.scrollToTop()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isTabBarDisabled = false
            }
        }
        lastSelectedViewController = viewController
    }
    
    private func setupControllers() {
        
        let characterListViewController = CharacterListViewController()
        let characterListViewModel = CharacterListViewModel()
        characterListViewController.viewModel = characterListViewModel
        characterListViewController.tabBarItem = UITabBarItem(title: "All", image: UIImage.getImage(.characterListIcon), tag: 0)
        
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewController.viewModel = searchViewModel
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.getImage(.searchIcon), tag: 1)
        
        let favouriteListViewController = FavouriteListViewController()
        let favouriteListViewModel = FavouriteListViewModel()
        favouriteListViewController.viewModel = favouriteListViewModel
        favouriteListViewController.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage.getImage(.heartIcon), tag: 2)
        
        self.viewControllers = [characterListViewController, searchViewController, favouriteListViewController]
    }
    
    private func configureTabBarNavigationBar() {
        tabBar.barTintColor = .backgroundGray
        tabBar.tintColor = .white
    }
}



