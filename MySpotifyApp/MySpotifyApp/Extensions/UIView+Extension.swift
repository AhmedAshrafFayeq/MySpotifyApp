//
//  UIView+Extension.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 28/03/2022.
//

import UIKit

extension UIView{
    //varaidic parameters
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
}
