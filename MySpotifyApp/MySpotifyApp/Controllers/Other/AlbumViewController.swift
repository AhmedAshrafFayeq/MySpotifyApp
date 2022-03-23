//
//  AlbumViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 23/03/2022.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private var album: Album
    
    init(album: Album){
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
    }
}
