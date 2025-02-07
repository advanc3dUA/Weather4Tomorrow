//
//  WeatherView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            if let weather = viewModel.currentWeather {
                Text("Temperature: \(weather.current.temperature2m)°C")
            } else {
                Text("Loading weather...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeather(latitude: 53.619653, longitude: 10.079969)
            }
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel(weatherService: WeatherService()))
}
