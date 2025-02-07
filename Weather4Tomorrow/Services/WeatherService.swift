//
//  WeatherService.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation
import OpenMeteoSdk

class WeatherService {
    static func fetchData(latitude: Double, longitude: Double) async throws {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin&format=flatbuffers"

        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.failedToCreateURL
        }
        
        guard let responses = try? await WeatherApiResponse.fetch(url: url) else {
            throw WeatherServiceError.failedToFetchData
        }
        
        print("LOG: number of objects in responses: \(responses.count)")
        
        let utcOffsetSeconds = responses[0].utcOffsetSeconds
        
        guard let current = responses[0].current,
              let hourly = responses[0].hourly,
              let daily = responses[0].daily else {
            throw WeatherServiceError.failedToExtractDataForcasts
        }
        
        guard let currentVariables0 = current.variables(at: 0),
              let currentVariables1 = current.variables(at: 1),
              let hourlyVariables0 = hourly.variables(at: 0),
              let hourlyVariables1 = hourly.variables(at: 1),
              let dailyVariables0 = daily.variables(at: 0),
              let dailyVariables1 = daily.variables(at: 1),
              let dailyVariables2 = daily.variables(at: 2) else {
            throw WeatherServiceError.receivedCorruptedData
        }
        
        /// Note: The order of weather variables in the URL query and the `at` indices below need to match!
        let data = WeatherData(
            current: .init(
                time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                temperature2m: currentVariables0.value,
                weatherCode: currentVariables1.value
            )
            ,
            hourly: .init(
                time: hourly.getDateTime(offset: utcOffsetSeconds),
                temperature2m: hourlyVariables0.values,
                weatherCode: hourlyVariables1.values
            )
            ,
            daily: .init(
                time: daily.getDateTime(offset: utcOffsetSeconds),
                weatherCode: dailyVariables0.values,
                temperature2mMax: dailyVariables1.values,
                temperature2mMin: dailyVariables2.values
            )
        )
        
        /// Timezone `.gmt` is deliberately used.
        /// By adding `utcOffsetSeconds` before, local-time is inferred
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        print("RESULTS ARE:")
        print("CURRENT LOCATION:")
        print("date: \(dateFormatter.string(from: data.current.time))")
        print("temp: \(data.current.temperature2m)")
        print("weatherCode: \(data.current.weatherCode)")
        
        print("START OF HOURLY:")
        for (i, date) in data.hourly.time.enumerated() {
            print("date: \(dateFormatter.string(from: date))")
            print("temp: \(data.hourly.temperature2m[i])")
            print("weatherCode: \(data.hourly.weatherCode[i])")
        }
        
        print("START OF DAILY:")
        for (i, date) in data.daily.time.enumerated() {
            print("date: \(dateFormatter.string(from: date))")
            print("weatherCode: \(data.daily.weatherCode[i])")
            print("tempMax: \(data.daily.temperature2mMax[i])")
            print("tempMin: \(data.daily.temperature2mMin[i])")
        }
        print("END_OF_DATA")
    }
}
