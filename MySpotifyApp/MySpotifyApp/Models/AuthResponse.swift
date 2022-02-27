//
//  AuthResponse.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 27/02/2022.
//

import Foundation

struct AuthResponse{
    let access_token: String
    let expires_in: String
    let refresh_token: String
    let scope: String
    let token_type: String
}
