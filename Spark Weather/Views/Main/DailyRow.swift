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

    var body: some View {
        VStack {
            HStack {
                Text("Day")
                Image(systemName: "cloud.fill")
                    .foregroundColor(Color.theme.secondary)
                Spacer()
                Text("\(round(min), specifier: "%g")° / \(round(max), specifier: "%g")°")
            }
            .font(.system(size: 20))
            .padding(.horizontal, 35)
            .padding(.vertical, 5)
            .foregroundColor(.white)
            Divider()
        }
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(model: weatherPreview, min: 12.5, max: 18.9)
            .background(Color.theme.background1)
    }
}
