//
//  AlbumDetailsResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 23/03/2022.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type, id, label, name: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let images: [Image]
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items:[AudioTrack]
}
