//
//  Geo.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation

typealias Geo = OpenWeatherMapAPI.Geo

extension OpenWeatherMapAPI {
    /// # Geo
    /// - A struct representing the Geo API response from OpenWeatherMap.
    ///
    /// ## Geo API 1.0
    /// API reference: [https://openweathermap.org/api/geocoding-api](https://openweathermap.org/api/geocoding-api)
    ///
    public struct Geo: Codable {
        public let geo: [GeoObject]
        
        public struct GeoObject: Codable, Hashable, Identifiable {
            public static func == (lhs: Geo.GeoObject, rhs: Geo.GeoObject) -> Bool {
                lhs.name < rhs.name
            }
            public let id = UUID()
            
            public let name: String
            public let localNames: [String: String]?
            public let lat: Double
            public let lon: Double
            public let country: String
            public let state: String?
            
            enum CodingKeys: String, CodingKey {
                case name
                case localNames = "local_names"
                case lat
                case lon
                case country
                case state
            }
        }
        
        static func getUrlString(q: String, limit: Int = 5) throws -> String {
            guard let apiKey = OpenWeatherMapAPI.getAPIKey else {
                throw "API key not found"
            }
            
            return "https://api.openweathermap.org/geo/1.0/direct?q=\(q)&limit=\(limit)&appid=\(apiKey)"
        }
        
        public init(geo: [GeoObject]) {
            self.geo = geo
        }
        
        public init(from urlString: String) throws {
            self.geo = try getParsedDataFromURL(from: urlString)
        }
        
        public init(q: String) throws {
            let urlString = try Geo.getUrlString(q: q)
            self.geo = try getParsedDataFromURL(from: urlString)
        }
        
    }
    
}
