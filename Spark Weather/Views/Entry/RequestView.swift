//
//  EntryView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 16/05/2022.
//

import SwiftUI

struct RequestView: View {
    
    @EnvironmentObject var weather: ContentModel
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack(spacing: 10) {
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 187)
                    .padding(.bottom, 50)
                Text("Welcome to the Spark Weather.")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.secondary)
                Text("Please share your location in settings to access weather in your area.")
                    .padding()
                    .foregroundColor(Color.theme.secondary)
                Button {
                    weather.requestLocation()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(animate ? Color.black : Color.theme.secondary)
                            .opacity(0.9)
                            
                        HStack {
                            Image(systemName: "location")
                            Text("Share your location")
                        }
                        .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                }
            }
            .multilineTextAlignment(.center)
            .onAppear(perform: animation)
        }
    }
    
    private func animation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(
                Animation
                    .easeInOut(duration: 4.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
