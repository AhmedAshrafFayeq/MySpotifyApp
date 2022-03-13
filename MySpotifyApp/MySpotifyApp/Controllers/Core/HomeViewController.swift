//
//  HomeViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettings))
        
        fetchData()
        
    }
    
    private func fetchData(){
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
    }

    @objc func didTapSettings(){
        let profileViewController = SettingsViewController()
        profileViewController.title = "Settings"
        profileViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
