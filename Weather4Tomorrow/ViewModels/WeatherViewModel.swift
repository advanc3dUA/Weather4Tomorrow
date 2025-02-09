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
    var currentIndex = 0
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
    }

    func startUpdatingWeather() {
        task = Task {
            while !Task.isCancelled {
                let location = coordinates[currentIndex]
                let result = await updateWeather(for: location)
                
                switch result {
                case .success(let newWeather):
                    self.weather = newWeather
                    self.currentBackground = newWeather.backgroundGradient
                    self.error = nil
                    
                case .failure(let error):
                    self.error = error.localizedDescription
                }
                            
                currentIndex = (currentIndex + 1) % coordinates.count
                try? await Task.sleep(nanoseconds: Constants.updateTime)
            }
        }
    }
    
    func stopCurrentTask() {
        task?.cancel()
    }
    
    private func updateWeather(for location: Coordinate) async -> Result<WeatherUI, AppError> {
        let weatherResult = await fetchWeatherData(for: location)
        let cityResult = await fetchCityNameFor(latitude: location.latitude, longitude: location.longitude)
        
        switch (weatherResult, cityResult) {
        case (.success(let weatherData), .success(let cityName)):
            let weatherUI = weatherData.toWeatherUI(with: cityName)
            return .success(weatherUI)
        case (.failure(let error), _):
            return .failure(error)
        case (_, .failure(let error)):
            return .failure(error)
        }
    }
    
    private func fetchWeatherData(for location: Coordinate) async -> Result<WeatherData, AppError> {
        do {
            let data = try await weatherService.fetchData(latitude: location.latitude, longitude: location.longitude)
            return .success(data)
        } catch {
            if let error = error as? AppError.WeatherServiceError {
                return .failure(.weatherServiceError(error))
            } else {
                return .failure(.weatherViewModelError(.failedToReceiveWeatherData))
            }
        }
    }
    
    private func fetchCityNameFor(latitude: Double, longitude: Double) async -> Result<String, AppError> {
        do {
            let cityName = try await geocodingService.fetchCityName(latitude: latitude, longitude: longitude)
            return .success(cityName)
        } catch {
            if let error = error as? AppError.GeocodingServiceError {
                return .failure(.geoCodingServiceError(error))
            } else {
                return .failure(.weatherViewModelError(.failedToReceiveCityName))
            }
        }
    }
}
