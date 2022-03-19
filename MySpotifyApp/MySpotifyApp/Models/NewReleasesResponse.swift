//
//  NewReleasesResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 11/03/2022.
//

import Foundation

// MARK: - NewReleasesResponse
struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

// MARK: - Albums
struct AlbumResponse: Codable {
    let items: [Album]
}

// MARK: - Item
struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let id: String
    let images: [Image]?
    let name, releaseDate: String
    let totalTracks: Int
    let artists: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
        case id, images, name, artists
    }
}
