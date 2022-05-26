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
                    
//                    for i in result.current.weather {
//                        i.getIcon()
//                    }
                    
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

//
//struct WeatherModel: Decodable {
//    let lat, lon: Double?
//    let timezone: String?
//    let timezoneOffset: Int?
//    let current: Current?
//    let minutely: [Minutely]?
//    let hourly: [Current]?
//    let daily: [Daily]?
//    let alerts: [Alert]?
//
//    enum CodingKeys: String, CodingKey {
//        case lat, lon, timezone
//        case timezoneOffset = "timezone_offset"
//        case current, minutely, hourly, daily, alerts
//    }
//}
//
//// MARK: - Alert
//struct Alert: Decodable {
//    let senderName, event: String?
//    let start, end: Int?
//    let alertDescription: String?
//
//    enum CodingKeys: String, CodingKey {
//        case senderName = "sender_name"
//        case event, start, end
//        case alertDescription = "description"
//    }
//}
//
//// MARK: - Current
//struct Current: Decodable {
//    let dt: Int?
//    let sunrise, sunset: Int?
//    let temp, feelsLike: Double?
//    let pressure, humidity: Int?
//    let dewPoint, uvi: Double?
//    let clouds, visibility: Int?
//    let windSpeed: Double?
//    let windDeg: Int?
//    let windGust: Double?
//    let weather: [Weather]?
//    let pop: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case uvi, clouds, visibility
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, pop
//    }
//}
//
//// MARK: - Weather
//struct Weather: Decodable {
//    let id: Int?
//    let main, weatherDescription, icon: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
//
//// MARK: - Daily
//struct Daily: Decodable {
//    let dt, sunrise, sunset, moonrise: Int?
//    let moonset: Int?
//    let moonPhase: Double?
//    let temp: Temp?
//    let feelsLike: FeelsLike?
//    let pressure, humidity: Int?
//    let dewPoint, windSpeed: Double?
//    let windDeg: Int?
//    let windGust: Double?
//    let weather: [Weather]?
//    let clouds: Int?
//    let pop, rain, uvi: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, moonrise, moonset
//        case moonPhase = "moon_phase"
//        case temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, clouds, pop, rain, uvi
//    }
//}
//
//// MARK: - FeelsLike
//struct FeelsLike: Decodable {
//    let day, night, eve, morn: Double?
//}
//
//// MARK: - Temp
//struct Temp: Decodable {
//    let day, min, max, night: Double?
//    let eve, morn: Double?
//}
//
//// MARK: - Minutely
//struct Minutely: Decodable {
//    let dt, precipitation: Int?
//}
//
