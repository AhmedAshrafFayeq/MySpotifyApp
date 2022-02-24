//
//  AuthManager.swift
//  MySpotifyApp
//
//  Created by Ahmed Fayeq on 13/02/2022.
//

import Foundation
import UIKit

class AuthManager {
    
    static let shared = AuthManager()
    
    struct Constants{
        static let clientID = "a8c0410ca32145348527d31c05eb4229"
        static let clientSecret = "0e29c6ed26d4468aaba5fe9c2cbce9fa"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    }
    
    private init(){}

    public var signInURL: URL?{
        let redirectURI = "http://localhost:8888/callback";
        let scope = "user-read-private"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialoge=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool{
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken (code: String, completion: @escaping ((Bool)-> Void)){
        // Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("SUCCESS: \(json)")
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
            
            
        }.resume()
    }
    
    public func refreshAccessToken(){
        
    }
    
    private func cacheToken(){
    }
}
