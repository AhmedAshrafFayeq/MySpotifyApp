//
//  LibraryPlaylistsViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 21/04/2022.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        APICaller.shared.getCurrentUserPlaylists { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self.playlists = playlists
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
