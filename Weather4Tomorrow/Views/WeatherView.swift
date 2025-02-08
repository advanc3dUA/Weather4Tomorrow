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
        ZStack {
            if let weather = viewModel.weather {
                weather.backgroundGradient
                    .ignoresSafeArea()
            } else {
                LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }
            
            
            
            VStack {
                if let weather = viewModel.weather {
                    Text("Date: \(weather.currentUI.dayOfTheWeek)")
                    Text("City: \(weather.cityName)")
                    Text("Temperature: \(weather.currentUI.temperature2m)°C")
                    Image(systemName: weather.currentUI.weatherCode)
                } else {
                    Text("Loading weather...")
                }
            }
            .onAppear {
                viewModel.startUpdatingWeather()
            }
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel(weatherService: WeatherService(), geocodingService: GeocodingService()))
}
