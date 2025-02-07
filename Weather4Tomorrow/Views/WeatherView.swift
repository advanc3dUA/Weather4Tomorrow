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
                Text("City: \(viewModel.currentCityName)")
                Text("Temperature: \(weather.current.temperature2m)°C")
            } else {
                Text("Loading weather...")
            }
        }
        .onAppear {
            viewModel.startUpdatingWeather()
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel(weatherService: WeatherService(), geocodingService: GeocodingService()))
}
