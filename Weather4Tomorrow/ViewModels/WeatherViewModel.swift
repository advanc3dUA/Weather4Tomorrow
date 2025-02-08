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
    private let geocodingService: GeocodingServiceProtocol
    private var coordinates: [Coordinate] = Constants.coordinates
    private var currentIndex = 0
    private var task: Task<Void, Never>?
    
    @Published var weather: WeatherUI?

    init(weatherService: WeatherServiceProtocol, geocodingService: GeocodingServiceProtocol) {
        self.weatherService = weatherService
        self.geocodingService = geocodingService
        startUpdatingWeather()
    }

    func startUpdatingWeather() {
        task?.cancel()
        task = Task {
            while !Task.isCancelled {
                let location = coordinates[currentIndex]
                var weatherData: WeatherData?
                var cityName = ""
                
                do {
                    weatherData = try await weatherService.fetchData(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    print("Error fetching weather: \(error)")
                }
                
                do {
                    cityName = try await geocodingService.fetchCityName(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    cityName = "Unknown city"
                    print("Error fetching city name: \(error)")
                }
                
                if let data = weatherData {
                    self.weather = data.toWeatherUI(with: cityName)
                }
                
                currentIndex = (currentIndex + 1) % coordinates.count
                
                try? await Task.sleep(nanoseconds: Constants.updateTime)
            }
        }
    }

    func stopUpdatingWeather() {
        task?.cancel()
        task = nil
    }
}
