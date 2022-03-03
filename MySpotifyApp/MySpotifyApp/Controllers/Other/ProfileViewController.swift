//
//  ProfileViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        APICaller.shared.getCurrentUserProfile { result in
            switch result{
            case .success(let model):
                print(model)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
