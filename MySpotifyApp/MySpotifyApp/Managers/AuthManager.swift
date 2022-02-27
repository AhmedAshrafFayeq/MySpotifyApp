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
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "http://localhost:8888/callback")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else {return}
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
    }
    
    public func refreshAccessToken(){
        
    }
    
    private func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)!), forKey: "expiration")
    }
}
