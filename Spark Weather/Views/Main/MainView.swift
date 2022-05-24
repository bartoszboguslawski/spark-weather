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
        VStack {
            Text(model.timezone)
            Text("\(String(model.current.temp)) Celcius")
        }
    }
}


