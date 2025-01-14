//
//  LocationManager.swift
//  Qvik-Weather-Swift
//
//  Created by Oskari Saarinen on 9.1.2025.
//

import SwiftUI
import CoreLocation

/// A helper for accessing user's location data.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completion: ((Result<String, Error>) -> Void)?

    @Published var location: CLLocationCoordinate2D?
    @Published var cityName: String?
    @Published var countryName: String?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestLocation() throws {
        let authorizationStatus: CLAuthorizationStatus = self.locationManager.authorizationStatus
        
        if authorizationStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .denied || authorizationStatus == .restricted {
            throw LocationManagerError.locationAccessDenied
        } else {
            self.locationManager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus: CLAuthorizationStatus = manager.authorizationStatus
        
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            self.locationManager.requestLocation()
        } else if authorizationStatus == .denied || authorizationStatus == .restricted {
            self.completion?(.failure(LocationManagerError.locationAccessDenied))
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location.coordinate

        self.geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                self.cityName = placemark.locality
                self.countryName = placemark.country
            } else {
                self.cityName = nil
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager failed with error: \(error.localizedDescription)")
        self.completion?(.failure(error))
    }
    
    enum LocationManagerError: Error {
        case locationServicesNotEnabled
        case locationAccessDenied
    }
    
}
