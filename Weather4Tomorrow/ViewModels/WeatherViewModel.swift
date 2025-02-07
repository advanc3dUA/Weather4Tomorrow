//
//  WeatherViewModel.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    private let weatherService: WeatherServiceProtocol
    @Published var currentWeather: WeatherData?

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func fetchWeather(latitude: Double, longitude: Double) async {
        do {
            let weather = try await weatherService.fetchData(latitude: latitude, longitude: longitude)
            DispatchQueue.main.async {
                self.currentWeather = weather
            }
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
}
