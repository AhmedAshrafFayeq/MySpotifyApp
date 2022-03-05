//
//  SettingsModels.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 05/03/2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: ()-> Void
}
