//
//  CurrentWeatherView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 5.1.2025.
//

import SwiftUI

public struct CurrentWeatherView: View {
    @Binding var currentWeather: Onecall.CurrentWeather?
    
    var currentDayWeather: Onecall.DailyWeather?
    var city: String = ""
    
    public var body: some View {
        if let currentWeatherData = self.currentWeather, let currentDayWeatherData = self.currentDayWeather {
            CurrentWeatherDataView(
                city: self.city,
                currentWeather: currentWeatherData,
                currentDayWeather: currentDayWeatherData
            )
        } else {
            NoCurrentDayWeatherDataView()
        }
    }
}

private struct CurrentWeatherDataView: View {
    var city: String
    var currentWeather: Onecall.CurrentWeather
    var currentDayWeather: Onecall.DailyWeather
    
    var temperature: String {
        self.currentWeather.temp.roundedTemperature
    }
    var description: String {
        (self.currentWeather.weather.first?.description ?? "").capitalized
    }
    var minTemperature: String {
        self.currentDayWeather.temp.min.roundedTemperature
    }
    var maxTemperature: String {
        self.currentDayWeather.temp.max.roundedTemperature
    }
    var rain: String {
        self.currentDayWeather.rain?.roundedRain ?? "0"
    }
    
    var body: some View {
        VStack {
            Text(self.temperature)
                .font(.custom("Inter-Regular_Bold", size: 50))
            Text(self.city)
                .font(.custom("Inter-Regular_Bold", size: 30))
            Text(self.description)
                .font(.custom("Inter-Regular", size: 16))
            

            HStack {
                Spacer()
                
                Image("assets_weather_max_temperature")
                Text("Max \(self.maxTemperature)")
                
                Image("assets_weather_min_temperature")
                Text("Min \(self.minTemperature)")
                
                Image("assets_weather_rainy")
                Text("Rain \(self.rain)mm")
                
                Spacer()
            }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(10)
                .font(.custom("Inter-Regular", size: 16))
            
        }
            .foregroundStyle(Color.mainText)
        
    }
    
}

private struct NoCurrentDayWeatherDataView: View {
    var body: some View {
        Text("No Data Available")
            .font(.custom("Inter-Regular_Bold", size: 30))
            .foregroundStyle(Color.mainText)
    }
}

#if DEBUG
#Preview("With Data") {
    VStack {
        Spacer()
        CurrentWeatherView(
            currentWeather:
                .constant(
                    Onecall.sampleResponseHelsinki.weather.current!
                ),
            currentDayWeather:
                Onecall.sampleResponseHelsinki.weather.daily?.first!,
            city: "Helsinki"
        )
        Spacer()
    }
        .background(weatherBackgroundGradientView)
}

#Preview("No Data") {
    VStack {
        Spacer()
        CurrentWeatherView(
            currentWeather: .constant(nil),
            currentDayWeather: nil
        )
            .frame(maxWidth: .infinity)
        Spacer()
    }
        .background(weatherBackgroundGradientView)
}
#endif
