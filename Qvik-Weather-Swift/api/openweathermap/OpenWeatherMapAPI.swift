//
//  OpenWeatherMapAPI.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 10.1.2025.
//

import Foundation

/// # OpenWeatherMapAPI
/// - A struct for making API calls from the OpenWeatherMap.
///
/// API reference: [https://openweathermap.org/api](https://openweathermap.org/api)
///
public struct OpenWeatherMapAPI {
    static let apiKeyKeyInKeychain: String = "OPENWEATHERMAP_API_KEY"
    
    static var getAPIKey: String? {
        guard let key = getApiKeyFromKeychain(keyName: OpenWeatherMapAPI.apiKeyKeyInKeychain) else {
            print("API KEY 🔑 NOT FOUND FROM THE KEYCHAIN! 👎")
            return nil
        }
        
        print("API KEY 🔑 WAS FOUND FROM THE KEYCHAIN! 👍")
        
        return key
    }
    
    struct APIErrorResponse: Codable {
        let cod: Int
        let message: String
        let parameters: [String]?
    }
    
}
