//
//  WeatherService.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation
import OpenMeteoSdk

class WeatherService: WeatherServiceProtocol {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .gmt
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func fetchData(latitude: Double, longitude: Double) async throws -> WeatherData {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin&format=flatbuffers"

        guard let url = URL(string: urlString) else {
            throw AppError.WeatherServiceError.failedToCreateURL
        }
        
        guard let responses = try? await WeatherApiResponse.fetch(url: url) else {
            throw AppError.WeatherServiceError.failedToFetchData
        }
        
        let response = responses[0]
        let utcOffsetSeconds = response.utcOffsetSeconds
        
        guard let current = response.current,
              let hourly = response.hourly,
              let daily = response.daily else {
            throw AppError.WeatherServiceError.failedToExtractDataForcasts
        }
        
        guard let currentTemp = current.variables(at: 0),
              let currentWeatherCode = current.variables(at: 1),
              let hourlyTemp = hourly.variables(at: 0),
              let hourlyWeatherCode = hourly.variables(at: 1),
              let dailyWeatherCode = daily.variables(at: 0),
              let dailyTempMax = daily.variables(at: 1),
              let dailyTempMin = daily.variables(at: 2) else {
            throw AppError.WeatherServiceError.receivedCorruptedData
        }
        
        /// Note: The order of weather variables in the URL query and the `at` indices below need to match!
        let data = WeatherData(
            current: .init(
                time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                temperature2m: currentTemp.value,
                weatherCode: currentWeatherCode.value
            ),
            hourly: .init(
                time: hourly.getDateTime(offset: utcOffsetSeconds),
                temperature2m: hourlyTemp.values,
                weatherCode: hourlyWeatherCode.values
            ),
            daily: .init(
                time: daily.getDateTime(offset: utcOffsetSeconds),
                weatherCode: dailyWeatherCode.values,
                temperature2mMax: dailyTempMax.values,
                temperature2mMin: dailyTempMin.values
            )
        )        
        return data
    }
}
