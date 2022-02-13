//
//  TabBarViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC      = HomeViewController()
        let searchVC    = SearchViewController()
        let LibraryVC   = LibraryViewController()
        
        homeVC.title = "Home"
        searchVC.title = "Search"
        LibraryVC.title = "Library"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        LibraryVC.navigationItem.largeTitleDisplayMode = .always
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let LibraryNav = UINavigationController(rootViewController: LibraryVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"),  tag: 1)
        LibraryNav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"),  tag: 1)
         
        homeNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        LibraryNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNav, searchNav, LibraryNav], animated: true)
        
    }


}
