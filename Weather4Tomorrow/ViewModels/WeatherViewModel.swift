//
//  WeatherViewModel.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    private let weatherService: WeatherServiceProtocol
    private let geocodingService: GeocodingServiceProtocol
    private var coordinates: [Coordinate] = Constants.coordinates
    private var currentIndex = 0
    private var task: Task<Void, Never>?
    
    @Published var weather: WeatherUI?
    @Published var error: String?
    @Published var currentBackground: LinearGradient

    init(weatherService: WeatherServiceProtocol, geocodingService: GeocodingServiceProtocol) {
        self.weatherService = weatherService
        self.geocodingService = geocodingService
        self.currentBackground = LinearGradient(
            gradient: Gradient(colors: [.gray, .black]),
            startPoint: .top,
            endPoint: .bottom
        )
        startUpdatingWeather()
    }

    func startUpdatingWeather() {
        task?.cancel()
        task = Task {
            while !Task.isCancelled {
                let location = coordinates[currentIndex]
                var weatherData: WeatherData?
                var cityName = ""
                let unknownErrorString = "Unknown error occured in startUpdatingWeather method. Perhaps you need to check your internet connection or just ignore it and go for a walk, regardless of what the weather is like there"
                do {
                    weatherData = try await weatherService.fetchData(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    if let weatherServiceError = error as? WeatherServiceError {
                        self.error = weatherServiceError.localizedDescription
                    } else {
                        self.error = "[Weather Service] \(unknownErrorString)"
                    }
                }
                
                do {
                    cityName = try await geocodingService.fetchCityName(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    cityName = "Unknown city"
                    if let geocodingServiceError = error as? GeocodingServiceError {
                        self.error = geocodingServiceError.localizedDescription
                    } else {
                        self.error = "[Geocoding Service] \(unknownErrorString)"
                    }
                }
                
                withAnimation(.easeOut(duration: 0.5)) {
                    weather = nil
                }
                
                if let data = weatherData {
                    let newWeather = data.toWeatherUI(with: cityName)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.weather = newWeather
                        self.currentBackground = newWeather.backgroundGradient
                        self.error = nil
                    }
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
