//
//  PlaylistDetailsResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 26/03/2022.
//

import Foundation

// MARK: - PlaylistDetailsResponse
struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [Image]
    let name: String
    let tracks: PlaylistTracksResponse
}
    
// MARK: - PlaylistTracksResponse
struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

// MARK: - PlaylistItem
struct PlaylistItem: Codable {
    let track: AudioTrack
}
