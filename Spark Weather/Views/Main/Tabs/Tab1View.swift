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
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .frame(width: 100, height: 70)
                        .foregroundColor(Color.theme.background2)
                    Spacer()
                    Text("\(round(model.current.temp), specifier: "%g")°")
                        .font(.system(size: 90, weight: .regular, design: .default))
                    .foregroundColor(Color.white)
                }
                .padding(.horizontal, 40.0)
                ForEach(model.current.weather, id: \.self) { r in
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
