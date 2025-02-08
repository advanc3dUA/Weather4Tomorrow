//
//  WeatherData+toWeatherUI.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import Foundation

extension WeatherData {
    func toWeatherUI(with cityName: String) -> WeatherUI {
        let currentUI = createCurrentUI()
        let hourlyUI = createHourlyUI()
        let dailyUI = createDailyUI()
        return WeatherUI(cityName: cityName,
                         currentUI: currentUI,
                         hourlyUI: hourlyUI,
                         dailyUI: dailyUI)
    }
    
    private func createCurrentUI() -> WeatherUI.CurrentUI {
        let dayOfTheWeek = DateFormatter.dayOfTheWeekFormatter.string(from: self.current.time)
        let temperature = roundTemperature(self.current.temperature2m)
        print("received weatherCode: \(current.weatherCode)")
        let weatherCode = convertToSFSymbolString(weatherCode: self.current.weatherCode)
        return WeatherUI.CurrentUI(dayOfTheWeek: dayOfTheWeek,
                                   temperature2m: temperature,
                                   weatherCode: weatherCode)
    }
    
    private func createHourlyUI() -> [WeatherUI.HourlyUI] {
        let hourlyCount = min(24, self.hourly.time.count)
        let hourlyUI: [WeatherUI.HourlyUI] = (0..<hourlyCount).map { index in
            let time = DateFormatter.hourlyFormatter.string(from: self.hourly.time[index])
            let temperature = roundTemperature(self.hourly.temperature2m[index])
            let weatherCode = convertToSFSymbolString(weatherCode: self.hourly.weatherCode[index])
            return WeatherUI.HourlyUI(time: time,
                                      temperature2m: temperature,
                                      weatherCode: weatherCode)
        }
        return hourlyUI
    }
    
    private func createDailyUI() -> [WeatherUI.DailyUI] {
        let dailyUI: [WeatherUI.DailyUI] = self.daily.time.enumerated().map { index, timeDate in
            let time = DateFormatter.dailyFormatter.string(from: timeDate)
            let weatherCode = convertToSFSymbolString(weatherCode: self.daily.weatherCode[index])
            let temperatureMin = roundTemperature(self.daily.temperature2mMin[index])
            let temperatureMax = roundTemperature(self.daily.temperature2mMax[index])
            return WeatherUI.DailyUI(time: time,
                                     weatherCode: weatherCode,
                                     temperature2mMin: temperatureMin,
                                     temperature2mMax: temperatureMax)
        }
        return dailyUI
    }
    
    private func roundTemperature(_ temperature: Float) -> Int {
        Int(temperature.rounded())
    }
    
    private func convertToSFSymbolString(weatherCode: Float) -> String {
        switch Int(weatherCode) {
            case 0:
                // 0: Clear sky
                return "sun.max.fill"
                
            case 1, 2, 3:
                // Mainly clear, partly cloudy, and overcast
                return "cloud.sun.fill"
                
            case 45, 48:
                // Fog and depositing rime fog
                return "cloud.fog.fill"
                
            case 51, 53, 55:
                // Drizzle: Light, moderate, and dense intensity
                return "cloud.drizzle.fill"
                
            case 56, 57:
                // Freezing Drizzle: Light and dense intensity
                return "cloud.sleet.fill"
                
            case 61, 63, 65:
                // Rain: Slight, moderate and heavy intensity
                return "cloud.rain.fill"
                
            case 66, 67:
                // Freezing Rain: Light and heavy intensity
                return "cloud.rain.fill"
                
            case 71, 73, 75:
                // Snow fall: Slight, moderate, and heavy intensity
                return "cloud.snow.fill"
                
            case 77:
                // Snow grains
                return "snow"
                
            case 80, 81, 82:
                // Rain showers: Slight, moderate, and violent
                return "cloud.heavyrain.fill"
                
            case 85, 86:
                // Snow showers slight and heavy
                return "cloud.snow.fill"
                
            case 95:
                // Thunderstorm: Slight or moderate
                return "cloud.bolt.fill"
                
            case 96, 99:
                // Thunderstorm with slight and heavy hail
                return "cloud.bolt.rain.fill"
                
            default:
                // Unknown weather code
                return "questionmark"
            }
    }
}
