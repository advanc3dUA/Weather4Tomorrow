//
//  Weather4TomorrowApp.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import SwiftUI

@main
struct Weather4TomorrowApp: App {
    private let weatherService = WeatherService()
    private let geocodingService = GeocodingService()
    private let weatherViewModel: WeatherViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        self.weatherViewModel = WeatherViewModel(weatherService: weatherService, geocodingService: geocodingService)
        
    }
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(weatherViewModel)
                .preferredColorScheme(.light)
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                weatherViewModel.stopCurrentTask()
                weatherViewModel.startUpdatingWeather()
            case .background, .inactive:
                weatherViewModel.stopCurrentTask()
            @unknown default:
                break
            }
        }
    }
}
