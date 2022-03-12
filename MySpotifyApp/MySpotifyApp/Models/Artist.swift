//
//  Artist.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import Foundation

// MARK: - Artist
struct Artist: Codable{
    let href, id, name, type, uri: String
    let externalURls: [String: String]
    
    enum CodingKeys: String, CodingKey{
        case externalURls = "external_urls"
        case href, id, name, type, uri
    }
}
