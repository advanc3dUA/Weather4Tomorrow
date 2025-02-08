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
        ZStack(alignment: .top) {
            if let weather = viewModel.weather {
                weather.backgroundGradient
                    .ignoresSafeArea()
                
                VStack {
                    CurrentDayView(cityName: weather.cityName, currentWeather: weather.currentUI)
                        .padding(.top, 25)
                    
                    Next24HoursView(hourlyData: weather.hourlyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.horizontal, 25)
                    
                    Spacer()
                }
                
            } else {
                LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
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
