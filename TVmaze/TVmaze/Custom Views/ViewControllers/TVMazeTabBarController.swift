//
//  TVMazeTabBarController.swift
//  TVmaze
//
//  Created by Fabricio Pujol on 19/01/23.
//

import UIKit

class TVMazeTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }

    func createSearchNavigationController() -> UINavigationController {
        let searchVC = TVShowsViewController(viewModel: TVShowsViewModel())
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }

    func createFavoritesNavigationController() -> UINavigationController {
        let favoriteListVC = FavoritesTvShowsViewController(viewModel: FavoritesTVShowsViewModel())
        favoriteListVC.title = "Favorites"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
