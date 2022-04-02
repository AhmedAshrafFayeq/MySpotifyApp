//
//  AllCategoriesResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 02/04/2022.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id, name: String
    let icons: [Image]
}
