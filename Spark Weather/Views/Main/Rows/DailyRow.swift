//
//  DailyRow.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 25/05/2022.
//

import SwiftUI

struct DailyRow: View {
    
    var model: WeatherModel
    var min: Double
    var max: Double
    var dt: Int
    var weather: [Weather]
    var body: some View {
        VStack {
            Divider()
            HStack {
                if let time = TimeInterval(dt) {
                    
                    Text("\(Date(timeIntervalSince1970: time).formatted(.dateTime.weekday()))")
                        .font(.system(size: 20))
                }
                ForEach(weather) { id in
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(id.icon)@2x.png")) { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Spacer()
                Text("\(round(min), specifier: "%g")° / \(round(max), specifier: "%g")°")
                    .font(.system(size: 20))
            }
            .padding(.horizontal, 35)
            .foregroundColor(Color.theme.secondaryColor)
        }
    }
}
