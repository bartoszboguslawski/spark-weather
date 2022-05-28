//
//  Tab2View.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 25/05/2022.
//

import SwiftUI

struct Tab2View: View {
    
    var model: WeatherModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.4)
            if model.current != nil {
                VStack {
                    HStack {
                        Text("Feels like:")
                        Spacer()
                        Text("\(round(model.current!.feelsLike ?? 0), specifier: "%g")°")
                    }
                    Divider()
                    HStack {
                        Text("Pressure:")
                        Spacer()
                        Text("\(model.current!.pressure ?? 0) hPa")
                    }
                    Divider()
                    HStack {
                        Text("Wind:")
                        Spacer()
                        Text("\(model.current!.windSpeed ?? 0, specifier: "%g") km/h")
                    }
                    Divider()
                    HStack {
                        Text("Visibility:")
                        Spacer()
                        Text("\((model.current!.visibility ?? 0)/1000) km")
                    }
                    Divider()
                    HStack {
                        Text("Humidity:")
                        Spacer()
                        Text("\(model.current!.humidity ?? 0) %")
                    }
                }
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}

struct Tab2View_Previews: PreviewProvider {
    static var previews: some View {
        Tab2View(model: weatherPreview)
            .frame(height: 250, alignment: .center)
            .cornerRadius(10)
            .tabViewStyle(PageTabViewStyle())
            .padding()
    }
}
