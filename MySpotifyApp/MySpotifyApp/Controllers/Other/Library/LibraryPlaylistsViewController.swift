//
//  LibraryPlaylistsViewController.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 21/04/2022.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNoPlaylistsView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
    }
    
    private func setupNoPlaylistsView() {
        noPlaylistsView.configure(
            with:
                ActionLabelViewViewModel(
                    text: "You don't have any playlists yet.",
                    actionTitle: "Create"
                )
        )
        view.addSubviews(noPlaylistsView)
        noPlaylistsView.delegate = self
    }
    
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self.playlists = playlists
                    self.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            //show empty label
            noPlaylistsView.isHidden = false
        }else {
            // show table
        }
    }
}

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // See creation UI
    }
    
}
