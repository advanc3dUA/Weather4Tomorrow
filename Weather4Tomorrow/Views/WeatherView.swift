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
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.horizontal, 25)
                    
                    Next7DaysView(daysData: weather.dailyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.horizontal, 25)
                        .padding(.bottom, 25)
                    
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
