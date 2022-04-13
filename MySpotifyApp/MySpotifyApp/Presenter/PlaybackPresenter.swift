//
//  PlaybackPresenter.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 09/04/2022.
//

import Foundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String?   { get }
    var subtitle: String?   { get }
    var imageURL: URL?      { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        nil
    }
    
    var subtitle: String? {
        nil
    }
    
    var imageURL: URL? {
        nil
    }
    
    
}
