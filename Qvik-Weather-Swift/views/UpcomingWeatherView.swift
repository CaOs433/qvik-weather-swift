//
//  UpcomingWeatherView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 7.1.2025.
//

import SwiftUI

public struct UpcomingWeatherView: View {
    @Binding var weather: [Onecall.DailyWeather]
    
    public var body: some View {
        ForEach(weather) { dayWeather in
            UpcomingDayWeatherView(weather: dayWeather)
                .overlay(alignment: .center) {
                    RoundedRectangle(
                        cornerRadius: 15
                    )
                        .stroke(Color.mainBorder, lineWidth: 2)
                }
        }
    }
    
}

#if DEBUG
#Preview {
    ScrollView {
        UpcomingWeatherView(weather:
                .constant(
                    Onecall.sampleResponseHelsinki.weather.daily!
                )
        )
    }.background(weatherBackgroundGradientView)
}
#endif
