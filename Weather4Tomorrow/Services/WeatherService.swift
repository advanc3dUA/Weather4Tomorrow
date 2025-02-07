//
//  WeatherService.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation
import OpenMeteoSdk

class WeatherService {
    static func fetchData(latitude: Double, longitude: Double) async {
        /// Make sure the URL contains `&format=flatbuffers`
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin&format=flatbuffers"
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,weather_code&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Europe%2FBerlin&format=flatbuffers")!
        
        do {
            let responses = try await WeatherApiResponse.fetch(url: url)
            /// Process first location. Add a for-loop for multiple locations or weather models
            print("LOG: number of objects in responses: \(responses.count)")
            let response = responses[0]
            
            /// Attributes for timezone and location
            let utcOffsetSeconds = response.utcOffsetSeconds
            
            let current = response.current!
            
            let hourly = response.hourly!
            
            let daily = response.daily!
            
            /// Note: The order of weather variables in the URL query and the `at` indices below need to match!
            let data = WeatherData(
                current: .init(
                    time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                    temperature2m: current.variables(at: 0)!.value,
                    weatherCode: current.variables(at: 1)!.value
                )
                ,
                hourly: .init(
                    time: hourly.getDateTime(offset: utcOffsetSeconds),
                    temperature2m: hourly.variables(at: 0)!.values,
                    weatherCode: hourly.variables(at: 1)!.values
                )
                ,
                daily: .init(
                    time: daily.getDateTime(offset: utcOffsetSeconds),
                    weatherCode: daily.variables(at: 0)!.values,
                    temperature2mMax: daily.variables(at: 1)!.values,
                    temperature2mMin: daily.variables(at: 2)!.values
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
        } catch {
            fatalError("Failed to get data")
        }
    }
}
