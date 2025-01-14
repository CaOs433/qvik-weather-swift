//
//  Onecall.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation

typealias Onecall = OpenWeatherMapAPI.Onecall

extension OpenWeatherMapAPI {
    /// # Onecall
    /// - A struct representing the Onecall API response from OpenWeatherMap.
    ///
    /// ## One Call API 3.0
    /// API reference: [https://openweathermap.org/api/one-call-3](https://openweathermap.org/api/one-call-3)
    ///
    public struct Onecall {
        public let weather: WeatherResponse
        
        public struct WeatherResponse: Codable {
            let lat: Double
            let lon: Double
            let timezone: String
            let timezoneOffset: Int
            let current: CurrentWeather?
            let minutely: [MinutelyWeather]?
            let hourly: [HourlyWeather]?
            let daily: [DailyWeather]?
            let alerts: [WeatherAlert]?
            
            enum CodingKeys: String, CodingKey {
                case lat, lon, timezone
                case timezoneOffset = "timezone_offset"
                case current, minutely, hourly, daily, alerts
            }
        }

        struct CurrentWeather: Codable {
            let dt: Int
            let sunrise: Int
            let sunset: Int
            let temp: Double
            let feelsLike: Double
            let pressure: Int
            let humidity: Int
            let dewPoint: Double
            let uvi: Double
            let clouds: Int
            let visibility: Int
            let windSpeed: Double
            let windDeg: Int
            let windGust: Double?
            let weather: [Weather]
            let rain: Rain?
            let snow: Snow?
            
            enum CodingKeys: String, CodingKey {
                case dt, sunrise, sunset, temp
                case feelsLike = "feels_like"
                case pressure, humidity
                case dewPoint = "dew_point"
                case uvi, clouds, visibility
                case windSpeed = "wind_speed"
                case windDeg = "wind_deg"
                case windGust = "wind_gust"
                case weather, rain, snow
            }
        }

        struct MinutelyWeather: Codable {
            let dt: Int
            let precipitation: Double
        }

        struct HourlyWeather: Codable {
            let dt: Int
            let temp: Double
            let feelsLike: Double
            let pressure: Int
            let humidity: Int
            let dewPoint: Double
            let uvi: Double
            let clouds: Int
            let visibility: Int
            let windSpeed: Double
            let windDeg: Int
            let windGust: Double?
            let weather: [Weather]
            let pop: Double
            let rain: Rain?
            let snow: Snow?
            
            enum CodingKeys: String, CodingKey {
                case dt, temp
                case feelsLike = "feels_like"
                case pressure, humidity
                case dewPoint = "dew_point"
                case uvi, clouds, visibility
                case windSpeed = "wind_speed"
                case windDeg = "wind_deg"
                case windGust = "wind_gust"
                case weather, pop, rain, snow
            }
        }

        struct DailyWeather: Codable, Hashable, Identifiable, Comparable {
            static func < (lhs: Onecall.DailyWeather, rhs: Onecall.DailyWeather) -> Bool {
                lhs.dt < rhs.dt
            }
            
            static func == (lhs: Onecall.DailyWeather, rhs: Onecall.DailyWeather) -> Bool {
                lhs.dt < rhs.dt
            }
            
            let id = UUID()
            
            let dt: Int
            let sunrise: Int
            let sunset: Int
            let moonrise: Int
            let moonset: Int
            let moonPhase: Double
            let summary: String
            let temp: Temperature
            let feelsLike: FeelsLike
            let pressure: Int
            let humidity: Int
            let dewPoint: Double
            let windSpeed: Double
            let windDeg: Int
            let windGust: Double?
            let weather: [Weather]
            let clouds: Int
            let pop: Double
            let rain: Double?
            let snow: Double?
            let uvi: Double
            
            enum CodingKeys: String, CodingKey {
                case dt, sunrise, sunset, moonrise, moonset
                case moonPhase = "moon_phase"
                case summary, temp
                case feelsLike = "feels_like"
                case pressure, humidity
                case dewPoint = "dew_point"
                case windSpeed = "wind_speed"
                case windDeg = "wind_deg"
                case windGust = "wind_gust"
                case weather, clouds, pop, rain, snow, uvi
            }
        }

        struct Temperature: Codable, Hashable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }

        struct FeelsLike: Codable, Hashable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }

        struct Weather: Codable, Hashable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
        
        struct Rain: Codable {
            let oneHour: Double?
            
            enum CodingKeys: String, CodingKey {
                case oneHour = "1h"
            }
        }
        
        struct Snow: Codable {
            let oneHour: Double?
            
            enum CodingKeys: String, CodingKey {
                case oneHour = "1h"
            }
        }

        struct WeatherAlert: Codable {
            let senderName: String
            let event: String
            let start: Int
            let end: Int
            let description: String
            let tags: [String]
            
            enum CodingKeys: String, CodingKey {
                case senderName = "sender_name"
                case event, start, end, description, tags
            }
        }
        
        enum ExcludeWeatherItem: String, Codable {
            case current
            case minutely
            case hourly
            case daily
            case alerts
        }
        
        /// Temperature unit for the API call response data. If not provided in the API call, default unit will be Kelvin.
        enum TemperatureUnit: String, Codable {
            /// Celcius
            case metric
            /// Fahrenheit
            case imperial
            
            mutating func toggle() {
                switch self {
                case .metric: self = .imperial
                case .imperial: self = .metric
                }
            }
        }
        
        init(weather: WeatherResponse) {
            self.weather = weather
        }
        
        init(from urlString: String) throws {
            self.weather = try getParsedDataFromURL(from: urlString)
        }
        
        init(
            lat: String,
            lon: String,
            exclude: [ExcludeWeatherItem] = [],
            unit: TemperatureUnit = .metric
        ) throws {
            guard let apiKey = OpenWeatherMapAPI.getAPIKey else {
                throw "API key not found"
            }
            
            let excludeString = exclude.map(\.self.rawValue).joined(separator: ",")
            let unitString = unit.rawValue
            let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=\(excludeString)&units=\(unitString)&appid=\(apiKey)"
            
            try self.init(from: urlString)
        }
        
    }
    
}
