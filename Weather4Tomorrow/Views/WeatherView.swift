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
        Group {
            if let weather = viewModel.weather {
                VStack {
                    CurrentDayView(cityName: weather.cityName,
                                   currentWeather: weather.currentUI)
                        .padding(.top, 25)
                    
                    Next24HoursView(hourlyData: weather.hourlyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 25)
                    
                    Next7DaysView(daysData: weather.dailyUI)
                        .background(RegularMaterialBackgroundView().opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 25)
                        .padding(.bottom, 25)
                    
                    Spacer()
                }
                .background(viewModel.currentBackground.ignoresSafeArea())
//                .drawingGroup()
                .id(weather.cityName)
                .transition(
                    AnyTransition.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    )
                )
            } else {
                viewModel.currentBackground
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
