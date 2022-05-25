//
//  LaunchView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var weather: ContentModel
    var body: some View {
        VStack {
            if weather.authorizationState == .notDetermined {
                RequestView()
            } else if weather.authorizationState == .authorizedAlways ||
                      weather.authorizationState == .authorizedWhenInUse {
                if let model = weather.weatherData {
                    MainView(model: model)
                } else {
                    LoadingView()
                }
            } else {
                ForbiddenView()
            }
        }
    }
}

