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
    private var refreshingToken = false
    
    struct Constants{
        static let clientID = "a8c0410ca32145348527d31c05eb4229"
        static let clientSecret = "0e29c6ed26d4468aaba5fe9c2cbce9fa"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.iosacademy.io";
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"

    }
    
    private init(){}

    public var signInURL: URL?{
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool{
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMins: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMins) >= expirationDate
    }
    
    public func exchangeCodeForToken (code: String, completion: @escaping ((Bool)-> Void)){
        // Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {return}
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
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
                completion(true)
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
        
    ///Suplies valid token to be used with API calls
    public func withValidToken(completion: @escaping (String) -> Void){
        guard !refreshingToken else {
            //append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            //Refresh
            refreshIfNeeded { [weak self] success in
                guard let self = self else { return }
                if let token = self.accessToken, success {
                    completion(token)
                }
            }
        }
        else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: ((Bool) -> Void)?){
        
        guard !refreshingToken else { return }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        guard let refreshToken = refreshToken else { return }
        
        //refresh the Token
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion?(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else {return}
            self.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Horraaayyy successfully refreshed 💃💃")
                self.onRefreshBlocks.forEach { $0(result.access_token)}
                self.onRefreshBlocks.removeAll()
                self.cacheToken(result: result)
                completion?(true)
            }catch{
                print(error.localizedDescription)
                completion?(false)
            }
        }.resume()
        
    }
    
    private func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expiration")
    }
}
