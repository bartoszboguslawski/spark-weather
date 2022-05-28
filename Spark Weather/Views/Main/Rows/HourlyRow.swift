//
//  HourlyRow.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 26/05/2022.
//

import SwiftUI

struct HourlyRow: View {
    
    var model: WeatherModel
    var dt: Int?
    var temp: Double?
    var weather: [Weather]?
    
    var body: some View {
        VStack(spacing: 8) {
            if let time = TimeInterval(dt ?? 0) {
                
                Text("\(Date(timeIntervalSince1970: time).formatted(.dateTime.hour()))")
            }
            if weather != nil {
                ForEach(weather!) { id in
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(id.icon ?? "")@2x.png")) { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            Text("\(round(temp ?? 0), specifier: "%g")°")
        }
        .frame(width: 60, height: 90)
        .foregroundColor(Color.theme.secondaryColor)
    }
}
