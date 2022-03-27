//
//  PlaylistHeaderCollectionReusableView.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 27/03/2022.
//

import SDWebImage
import UIKit

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "PlaylistHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
