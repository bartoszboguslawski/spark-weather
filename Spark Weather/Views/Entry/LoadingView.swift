//
//  LoadingView.swift
//  Spark Weather
//
//  Created by Bartosz Bogusławski on 24/05/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            GradientBackground()
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
