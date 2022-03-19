//
//  NewReleaseCollectionViewCell.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 18/03/2022.
//

import UIKit

//struct NewReleasesCellViewModel{
//    let name, artistName: String
//    let artWorkURL: URL?
//    let numberOfTracks: Int
//}


class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        
    }
}
