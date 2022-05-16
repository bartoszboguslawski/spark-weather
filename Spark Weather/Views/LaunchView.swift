//
//  LaunchView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model: LocationManager
    
    var body: some View {
        VStack {
            if model.locationManager.authorizationStatus == .authorizedWhenInUse || model.locationManager.authorizationStatus == .authorizedAlways {
                MainView()
            } else if model.locationManager.authorizationStatus == .notDetermined {
                ProgressView()
            } else {
                RequestView()
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
