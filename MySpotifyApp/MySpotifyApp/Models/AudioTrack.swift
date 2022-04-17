//
//  AudioTrack.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import Foundation

struct AudioTrack: Codable{
    var album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number, duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id, name: String
    let preview_url: String?
}
