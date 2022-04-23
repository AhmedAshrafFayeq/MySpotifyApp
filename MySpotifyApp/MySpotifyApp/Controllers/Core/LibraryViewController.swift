//
//  LibraryViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.backgroundColor = .systemYellow
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        )
        
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        
    }
}
