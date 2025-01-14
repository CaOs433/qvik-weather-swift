//
//  setup.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 6.1.2025.
//

import Foundation
import CoreLocation

extension String: Error {}

func formatTimestamp(_ timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE dd.MM"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    return dateFormatter.string(from: date)
}

extension Int {
    var formattedTimestampWeekdayDDMM: String {
        formatTimestamp(self)
    }
    
}

extension Double {
    var roundedTemperature: String {
        let prefix: String = self < 0 ? "" : "+"
        
        return prefix + String(
            format: "%.1f",
            self
        )
            .replacingOccurrences(
                of: "\\.?0+$",
                with: "",
                options: .regularExpression
            )
    }
    
    var roundedRain: String {
        return String((self * 10).rounded() / 10)
            .replacingOccurrences(
                of: "\\.?0+$",
                with: "",
                options: .regularExpression
            )
    }
    
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}
