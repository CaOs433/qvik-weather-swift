//
//  WeatherIconTests.swift
//  Qvik-Weather-SwiftTests
//
//  Created by Oskari Saarinen on 14.1.2025.
//

import XCTest
@testable import Qvik_Weather_Swift

final class WeatherIconTests: XCTestCase {
    
    func testGetIconNameForValidIcons() {
        let testIcons = Onecall.Weather.icons
        
        for (iconKey, expectedIconName) in testIcons {
            let weather = Onecall.Weather(
                id: 0,
                main: "Test",
                description: "Test",
                icon: iconKey
            )
            XCTAssertEqual(
                weather.getIconName,
                expectedIconName,
                "Icon name mismatch for key: \(iconKey)"
            )
        }
    }
    
    func testGetIconNameForInvalidIcon() {
        let invalidIconKey = "invalid_key"
        
        let weather = Onecall.Weather(
            id: 0,
            main: "Test",
            description: "Test",
            icon: invalidIconKey
        )
        XCTAssertEqual(
            weather.getIconName,
            "question_mark_question_mark_symbol",
            "Unexpected icon name for invalid icon code"
        )
    }
    
    func testIconExistsInAssets() {
        let testIcons = Set(Onecall.Weather.icons.values)
        
        for iconName in testIcons {
            XCTAssertNotNil(
                UIImage(named: iconName),
                "Image \(iconName) not found in assets"
            )
        }
    }
    
    func testDefaultIconExistsInAssets() {
        let defaultIconName = "question_mark_question_mark_symbol"
        XCTAssertNotNil(
            UIImage(named: defaultIconName),
            "Default image \(defaultIconName) not found in assets"
        )
    }
    
}
