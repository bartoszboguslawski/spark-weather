//
//  ContentModel.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let apiKey = "2dc71d6c621cf96afd12b19fc208699f"
    @Published var weatherData: WeatherModel?
    
    var locationManager = CLLocationManager()
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        
        if location != nil {
            locationManager.stopUpdatingLocation()            
            dataRequest(lat: location!.latitude, lon: location!.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
    }


    func dataRequest(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric") else {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                do {
                    guard let data = data else {
                        print("Missing data")
                        return
                    }

                    guard let response = response as? HTTPURLResponse else {
                        print("Invalid response")
                        return
                    }
                    
                    guard response.statusCode >= 200 && response.statusCode < 300 else {
                        print("Invalid status code: \(response.statusCode)")
                        return
                    }
                    
                    print("Data downloaded")
                    
                    let result = try JSONDecoder().decode(WeatherModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.weatherData = result
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}
