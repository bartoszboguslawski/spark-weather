//
//  ForbiddenView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 19/05/2022.
//

import SwiftUI

struct ForbiddenView: View {
    var body: some View {
        ZStack {
            GradientBackground2()
            VStack(spacing: 20) {
                Text("Location denied.")
                    .font(.title)
                Text("If you want to see weather in your location, go to the settings and grant us permission to see where you are.")
                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.theme.secondaryColor)
                            
                        HStack {
                            Image(systemName: "location")
                            Text("Go to settings")
                        }
                        .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                }

            }
            .multilineTextAlignment(.center)
            .foregroundColor(Color.theme.secondaryColor)
            .padding()
        }
    }
}

struct ForbiddenView_Previews: PreviewProvider {
    static var previews: some View {
        ForbiddenView()
    }
}
