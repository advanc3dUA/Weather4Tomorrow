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
    private var coordinates: [Coordinate] = Constants.coordinates
    private var currentIndex = 0
    private var task: Task<Void, Never>?
    
    @Published var currentWeather: WeatherData?
    @Published var currentLocation: Coordinate?

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        startUpdatingWeather()
    }

    func startUpdatingWeather() {
        task?.cancel()
        task = Task {
            while !Task.isCancelled {
                let location = coordinates[currentIndex]
                currentLocation = location
                
                do {
                    currentWeather = try await weatherService.fetchData(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    print("Error fetching weather: \(error)")
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
