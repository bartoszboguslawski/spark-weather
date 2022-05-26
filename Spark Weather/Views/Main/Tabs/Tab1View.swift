//
//  Tab1View.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 24/05/2022.
//

import SwiftUI

struct Tab1View: View {
    
    var model: WeatherModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.4)
            VStack {
                HStack {
                    ForEach(model.current.weather) { id in
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(id.icon)@2x.png")) { image in
                            image
                                .resizable()
                                .frame(width: 120, height: 120)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Spacer()
                    Text("\(round(model.current.temp), specifier: "%g")°")
                        .font(.system(size: 90, weight: .regular, design: .default))
                    .foregroundColor(Color.white)
                }
                .padding(.horizontal, 40.0)
                ForEach(model.current.weather) { r in
                    Text(r.main)
                        .font(.title2)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

struct Tab1View_Previews: PreviewProvider {
    static var previews: some View {
        Tab1View(model: weatherPreview)
            .frame(height: 250, alignment: .center)
            .cornerRadius(10)
            .tabViewStyle(PageTabViewStyle())
            .padding()
    }
}
