//
//  UpcomingDayWeatherView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 5.1.2025.
//

import SwiftUI

public struct UpcomingDayWeatherView: View {
    @State private var isExpanded: Bool = false
    
    var weather: Onecall.DailyWeather
    
    public var body: some View {
        HStack {
            UpcomingDayWeatherLeftColumnView(weather: self.weather)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 20)
            
            UpcomingDayWeatherRightColumnView(
                isExpanded: self.$isExpanded,
                weather: self.weather
            )
            
            Spacer()
        }
            .padding()
            .foregroundStyle(Color.mainText)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
    }
    
}

private struct UpcomingDayWeatherLeftColumnView: View {
    var weather: Onecall.DailyWeather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.dt.formattedTimestampWeekdayDDMM)
        }
            .frame(alignment: .topLeading)
    }
    
}

private struct UpcomingDayWeatherRightColumnView: View {
    @Binding var isExpanded: Bool
    
    var weather: Onecall.DailyWeather
    
    var body: some View {
        VStack(alignment: .leading) {
            UpcomingDayWeatherRowItemView(
                iconName: "sunny_sunny_symbol",
                valuePrefix: "",
                value: self.weather.temp.day.roundedTemperature
            )
            
            if isExpanded {
                Group() {
                    UpcomingDayWeatherRowItemView(
                        iconName: "thermostat_arrow_up_thermostat_arrow_up_symbol",
                        valuePrefix: "Max ",
                        value: self.weather.temp.max.roundedTemperature
                    )
                    
                    UpcomingDayWeatherRowItemView(
                        iconName: "thermostat_arrow_down_thermostat_arrow_down_symbol",
                        valuePrefix: "Min ",
                        value: self.weather.temp.min.roundedTemperature
                    )
                    
                    UpcomingDayWeatherRowItemView(
                        iconName: "rainy_rainy_symbol",
                        valuePrefix: "Rain ",
                        value: (self.weather.rain ?? 0).roundedRain
                    )
                }
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
            }
        }
            .padding(.leading, 20)
    }
    
}

private struct UpcomingDayWeatherRowItemView: View {
    var iconName: String
    var valuePrefix: String
    var value: String
    
    var body: some View {
        HStack {
            Image(self.iconName).frame(alignment: .leading)
            Text(
                "\(self.valuePrefix)\(self.value)"
            )
                .padding(.leading, 20)
                .frame(alignment: .trailing)
            Spacer()
        }
    }
    
}

#if DEBUG
#Preview {
    VStack {
        Spacer()
        UpcomingDayWeatherView(
            weather:
                Onecall.sampleResponseHelsinki.weather.daily!.first!
        )
        Spacer()
    }.background(weatherBackgroundGradientView)
}
#endif
