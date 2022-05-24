//
//  Spark_WeatherApp.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import SwiftUI

@main
struct Spark_WeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
