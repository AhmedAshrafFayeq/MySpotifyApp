//
//  Artist.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import Foundation

// MARK: - Artist
struct Artist: Codable{
    let id, name, type: String
    let external_urls: [String: String]
    let images: [Image]?
}
