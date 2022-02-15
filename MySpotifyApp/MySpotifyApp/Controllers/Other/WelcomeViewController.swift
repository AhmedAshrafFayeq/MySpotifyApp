//
//  WelcomeViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign in with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    
    @objc func didTapSignIn() {
        let AuthVC = AuthViewController()
        AuthVC.completionHandler = { [weak self] success in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.handleSignIn(success: success)
            }
        }
        AuthVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(AuthVC, animated: true)
    }
    
    func handleSignIn(success: Bool){
        //log user in or yell at them for error
    }
}
