//
//  SearchResults.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 03/04/2022.
//

import Foundation

enum SearchResults {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
