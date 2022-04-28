//
//  LibraryPlaylistsViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 21/04/2022.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getCurrentUserPlaylists { result in
            switch result {
            case .success(let playlists): break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
