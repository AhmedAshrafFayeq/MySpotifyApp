//
//  FeaturedPlaylistCollectionViewCell.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 18/03/2022.
//

import UIKit

//let name, creatorName: String
//let artworkURL: URL?

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {    
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView   = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label   = UILabel()
        label.font  = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label   = UILabel()
        label.font  = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let imageSize: CGFloat = contentView.height-10
//        let playlistNameLabelSize = playlistNameLabel.sizeThatFits(
//            CGSize(width: contentView.width-imageSize-10,
//                   height: contentView.height-10
//                  )
//        )
//        creatorNameLabel.sizeToFit()
//
//        //Image
//        playlistCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
//
//        //Album name label
//        let albumLabelHeight = min(60, playlistNameLabelSize.height)
//        playlistNameLabel.frame = CGRect(
//            x: playlistCoverImageView.right+10,
//            y: 5,
//            width: playlistNameLabelSize.width,
//            height: albumLabelHeight
//        )
//
//        creatorNameLabel.frame = CGRect(
//            x: playlistCoverImageView.right+10,
//            y: playlistNameLabel.bottom,
//            width: contentView.width - playlistCoverImageView.right-10,
//            height: 30
//        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
