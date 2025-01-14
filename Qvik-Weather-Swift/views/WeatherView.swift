//
//  WeatherView.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 12.1.2025.
//

import SwiftUI
import CoreLocation

public struct WeatherView: View {
    @State var isSearching: Bool = false
    @State var selectedLocation: Geo.GeoObject? = nil
    @State var temperatureUnit: Onecall.TemperatureUnit = .metric
    @State var dailyWeather: [Onecall.DailyWeather] = []
    @State var currentWeather: Onecall.CurrentWeather? = nil
    
    @StateObject var locationManager = LocationManager()
    
    var currentDayWeather: Onecall.DailyWeather? {
        self.dailyWeather.min()
    }
    
    var currentLocationString: String {
        guard let cityName = self.locationManager.cityName, let countryName = self.locationManager.countryName else {
            return ""
        }
        
        return cityName + ", " + countryName
    }
    
    var locationToUse: CLLocationCoordinate2D? {
        if let selectedLocation {
            return CLLocationCoordinate2D(
                latitude: selectedLocation.lat,
                longitude: selectedLocation.lon
            )
        }
        
        return self.locationManager.location
    }
    
    var cityName: String? {
        self.selectedLocation?.name ?? self.locationManager.cityName
    }
    
    public var body: some View {
        ScrollView {
            FirstBlock(temperatureUnit: self.$temperatureUnit)
                .padding(.top)
            
            CurrentLocationView(currentLocationString: self.currentLocationString)

            LocationSearchView(
                isSearching: self.$isSearching,
                selectedLocation: self.$selectedLocation
            )
                .padding(.bottom, self.isSearching ? 400 : 0)
            
            if !self.isSearching {
                CurrentWeatherView(
                    currentWeather: self.$currentWeather,
                    currentDayWeather: self.currentDayWeather,
                    city: self.cityName ?? ""
                )
                
                UpcomingWeatherView(weather: self.$dailyWeather)
            }
            
            Spacer()

        }
        .padding(.horizontal)
            .background(
                weatherBackgroundGradientView
            )
            .onChange(of: self.locationManager.location) {
                self.getWeatherData()
            }
            .onChange(of: self.temperatureUnit) {
                self.getWeatherData()
            }
            .onChange(of: self.selectedLocation) {
                if self.isSearching {
                    self.isSearching = false
                }
                
                self.getWeatherData()
            }
    }
    
    func getWeatherData() {
        guard let location = self.locationToUse else {
            return
        }
        
        print("location: \(location)")
        
        do {
            let lat = String(location.latitude)
            let lon = String(location.longitude)
            let onecall = try Onecall(
                lat: lat,
                lon: lon,
                exclude: [.alerts, .hourly, .minutely],
                unit: self.temperatureUnit
            )
            
            self.currentWeather = onecall.weather.current
            
            if var daily = onecall.weather.daily, daily.count > 1 {
                daily.sort()
                daily.removeFirst() // Remove the current day
                self.dailyWeather = daily
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

private struct FirstBlock: View {
    @Binding var temperatureUnit: Onecall.TemperatureUnit
    
    var body: some View {
        HStack {
            Text("Weather\nSite")
                .font(.custom("Inter-Regular_Bold", size: 20))
                .foregroundColor(Color.white)

            Spacer()
            
            TemperatureToggleView(temperatureUnit: self.$temperatureUnit)
                .frame(width: 63, height: 30, alignment: .topTrailing)
        }
    }
    
}

private struct CurrentLocationView: View {
    var currentLocationString: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Your current location:")
                    .font(.custom("Inter-Regular_SemiBold", size: 14))
                Text(self.currentLocationString)
                        .font(.custom("Inter-Regular", size: 14))
            }
                .foregroundStyle(Color.white)
            Spacer()
        }
    }
    
}

#if DEBUG
#Preview {
    WeatherView(
        dailyWeather: Onecall.sampleResponseHelsinki.weather.daily!,
        currentWeather: Onecall.sampleResponseHelsinki.weather.current
    )
}
#endif
