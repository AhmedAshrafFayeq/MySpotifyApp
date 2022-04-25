//
//  LibraryToggleView.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 25/04/2022.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

enum State {
    case playlists
    case albums
}

class LibraryToggleView: UIView {
    
    weak var delegate: LibraryToggleViewDelegate?
    
    var state: State = .playlists
    
    private let playListButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(playListButton, albumsButton, indicatorView)
        
        playListButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapPlaylists() {
        state = .playlists
        UIView.animate(withDuration: 0.2) {
            self.layoutSubviews()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .albums
        UIView.animate(withDuration: 0.2) {
            self.layoutSubviews()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playListButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playListButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlists:
            indicatorView.frame = CGRect(x: 0, y: playListButton.bottom, width: 100, height: 3)

        case .albums:
            indicatorView.frame = CGRect(x: 100, y: playListButton.bottom, width: 100, height: 3)

        }
    }
}
