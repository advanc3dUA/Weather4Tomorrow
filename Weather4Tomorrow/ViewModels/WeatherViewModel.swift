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
    @Published var error: String?

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
                    if let weatherServiceError = error as? WeatherServiceError {
                        self.error = weatherServiceError.localizedDescription
                    } else {
                        self.error = "[Weather Service] Unknown error occured in startUpdatingWeather method"
                    }
                }
                
                do {
                    cityName = try await geocodingService.fetchCityName(latitude: location.latitude, longitude: location.longitude)
                } catch {
                    cityName = "Unknown city"
                    if let geocodingServiceError = error as? GeocodingServiceError {
                        self.error = geocodingServiceError.localizedDescription
                    } else {
                        self.error = "[Geocoding Service] Unknown error occured in startUpdatingWeather method"
                    }
                }
                
                if let data = weatherData {
                    self.weather = data.toWeatherUI(with: cityName)
                }
                
                print("Results in hourly:")
                weather?.hourlyUI.forEach({ hourly in
                    print("\(hourly.time); \(hourly.temperature2m), \(hourly.weatherCode)")
                })
                print("Results in daily:")
                weather?.dailyUI.forEach({ daily in
                    print("\(daily.time); \(daily.temperature2mMin), \(daily.temperature2mMax), \(daily.weatherCode)")
                })
                
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
