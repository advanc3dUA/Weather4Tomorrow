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
            viewModel.currentBackground
                .ignoresSafeArea()
                .zIndex(0)
            
            if let error = viewModel.error {
                OverlayView(text: error)
                    .zIndex(2)
            }
            
            if let weather = viewModel.weather {
                VStack {
                    CurrentDayView(cityName: weather.cityName,
                                   currentWeather: weather.currentUI)
                    .padding(.top, 25)
                    
                    Next24HoursView(hourlyData: weather.hourlyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        .padding(.horizontal, 25)
                    
                    Next7DaysView(daysData: weather.dailyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        .padding(.horizontal, 25)
                        .padding(.bottom, 25)
                    
                    Spacer()
                }
                .zIndex(1)
                .background(viewModel.currentBackground.ignoresSafeArea())
                .id(weather.cityName)
                .transition(
                    AnyTransition.opacity.animation(.default).combined(with: .slide)
                )
            }
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel(weatherService: WeatherService(), geocodingService: GeocodingService()))
}
