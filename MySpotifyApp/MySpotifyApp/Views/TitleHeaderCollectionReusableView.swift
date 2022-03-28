//
//  TitleHeaderCollectionReusableView.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 29/03/2022.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(label)
        label.frame = CGRect(x: 15, y: 0, width: width-30, height: height)
    }
    
    func configure(with title: String){
        label.text = title
    }
}
