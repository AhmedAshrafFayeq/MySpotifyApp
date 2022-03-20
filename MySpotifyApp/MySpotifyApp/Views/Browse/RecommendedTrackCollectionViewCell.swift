//
//  RecommendedTrackCollectionViewCell.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 18/03/2022.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {    
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView   = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius  = 8
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label   = UILabel()
        label.font  = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label   = UILabel()
        label.font  = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
