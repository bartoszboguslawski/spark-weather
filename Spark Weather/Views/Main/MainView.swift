//
//  ContentView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var weather: ContentModel
    var model: WeatherModel
    
    
    var body: some View {
        ZStack {
            GradientBackground()
            ScrollView {
                VStack {
                    TabView {
                        Tab1View(model: model)
                        Tab2View(model: model)
                    }
                    .frame(height: 250, alignment: .center)
                    .cornerRadius(10)
                    .tabViewStyle(PageTabViewStyle())
                    .padding()
                    .foregroundColor(Color.theme.tabcolor)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(model.hourly.prefix(24)) { hour in
                                HourlyRow(model: model, dt: hour.dt, temp: hour.temp, weather: hour.weather)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    
                    ForEach(model.daily) { day in
                        DailyRow(model: model, min: day.temp.min, max: day.temp.max, dt: day.dt, weather: day.weather)
                    }
                    
                }
            }
        }
    }
}


