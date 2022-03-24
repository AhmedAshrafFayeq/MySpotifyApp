//
//  RecommendationResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 15/03/2022.
//

import Foundation

struct RecommendationResponse: Codable{
    let tracks: [AudioTrack]
}

struct AudioTrack: Codable{
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number, duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id, name: String
}
