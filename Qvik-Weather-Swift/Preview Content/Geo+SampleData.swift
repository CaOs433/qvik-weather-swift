//
//  Geo+SampleData.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 11.1.2025.
//

import Foundation

extension Geo {
    static var sampleResponseCopen: Geo = Geo(
        geo: [
            Geo.GeoObject(
                name: "Copen",
                localNames: nil,
                lat: 38.8375952,
                lon: -80.7295431,
                country: "US",
                state: "West Virginia"
            ),
            Geo.GeoObject(
                name: "Suvorovo",
                localNames: [
                    "de": "Suworowo",
                    "en": "Suvorovo",
                    "lt": "Suopynai",
                    "ru": "Суворово"
                ],
                lat: 54.6235728,
                lon: 21.0323007,
                country: "RU",
                state: "Kaliningrad"
            )
        ]
    )
    
}
