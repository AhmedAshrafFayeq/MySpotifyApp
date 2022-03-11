//
//  NewReleasesResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 11/03/2022.
//

import Foundation

// MARK: - NewReleasesResponse
struct NewReleasesResponse: Codable {
    let albums: Albums
}

// MARK: - Albums
struct Albums: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
}

// MARK: - Item
struct Item: Codable {
}
