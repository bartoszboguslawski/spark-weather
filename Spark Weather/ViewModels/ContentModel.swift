//
//  ContentModel.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first
        
        if userLocation != nil {
            locationManager.startUpdatingLocation()
        }
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
}
