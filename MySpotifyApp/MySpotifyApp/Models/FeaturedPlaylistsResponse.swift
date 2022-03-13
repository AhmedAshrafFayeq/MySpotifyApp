//
//  FeaturedPlaylistsResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/03/2022.
//

import Foundation

// MARK: - FeaturedPlaylistsResponse
struct FeaturedPlaylistsResponse: Codable{
    let playlists: PlayListResponse
}

// MARK: - PlayListResponse
struct PlayListResponse: Codable{
    let items: [PlayList]
}

// MARK: - PlayList
struct PlayList: Codable{
    let collaborative: Int
    let description, id, name: String
    let external_urls: [String: String]
    let images: [Image]
    let owner: User
}

// MARK: - User
struct User: Codable{
    let display_name, id: String
    let external_urls: [String: String]
}
