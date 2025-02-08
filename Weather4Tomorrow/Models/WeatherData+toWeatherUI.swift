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
        return WeatherUI(
            cityName: cityName,
            currentUI: currentUI,
            hourlyUI: hourlyUI,
            dailyUI: dailyUI
        )
    }
    
    private func createCurrentUI() -> WeatherUI.CurrentUI {
        let dayOfTheWeek = DateFormatter.dayOfTheWeekFormatter.string(from: self.current.time)
        let temperature = roundTemperature(self.current.temperature2m)
        let weatherIcon = convertWeatherCodeToSFSymbolString(weatherCode: self.current.weatherCode)
        return WeatherUI.CurrentUI(
            dayOfTheWeek: dayOfTheWeek,
            temperature2m: temperature,
            weatherIcon: weatherIcon
        )
    }
    
    private func createHourlyUI() -> [WeatherUI.HourlyUI] {
        let calendar = Calendar.current
        
        guard let nextFullHour = calendar.nextDate(
            after: .now,
            matching: DateComponents(minute: 0, second: 0),
            matchingPolicy: .strict
        ) else {
            return (0..<min(24, self.hourly.time.count)).map { index in
                let time = DateFormatter.hourlyFormatter.string(from: self.hourly.time[index])
                let temperature = roundTemperature(self.hourly.temperature2m[index])
                let weatherIcon = convertWeatherCodeToSFSymbolString(weatherCode: self.hourly.weatherCode[index])
                return WeatherUI.HourlyUI(
                    time: time,
                    temperature2m: temperature,
                    weatherIcon: weatherIcon)
            }
        }
        
        let startIndex = self.hourly.time.firstIndex(where: { $0 >= nextFullHour} ) ?? 0
        let endIndex = min(startIndex + 24, self.hourly.time.count)
        
        let hourlyUI: [WeatherUI.HourlyUI] = (startIndex..<endIndex).map { index in
            let time = DateFormatter.hourlyFormatter.string(from: self.hourly.time[index])
            let temperature = roundTemperature(self.hourly.temperature2m[index])
            let weatherIcon = convertWeatherCodeToSFSymbolString(weatherCode: self.hourly.weatherCode[index])
            return WeatherUI.HourlyUI(
                time: time,
                temperature2m: temperature,
                weatherIcon: weatherIcon)
        }
        return hourlyUI
    }
    
    private func createDailyUI() -> [WeatherUI.DailyUI] {
        let dailyUI: [WeatherUI.DailyUI] = self.daily.time.enumerated().map { index, timeDate in
            let time = DateFormatter.dailyFormatter.string(from: timeDate)
            let weatherCode = convertWeatherCodeToSFSymbolString(weatherCode: self.daily.weatherCode[index])
            let temperatureMin = roundTemperature(self.daily.temperature2mMin[index])
            let temperatureMax = roundTemperature(self.daily.temperature2mMax[index])
            return WeatherUI.DailyUI(
                time: time,
                weatherIcon: weatherCode,
                temperature2mMin: temperatureMin,
                temperature2mMax: temperatureMax
            )
        }
        return dailyUI
    }
    
    private func roundTemperature(_ temperature: Float) -> Int {
        Int(temperature.rounded())
    }
    
    private func convertWeatherCodeToSFSymbolString(weatherCode: Float) -> String {
        switch Int(weatherCode) {
            case 0:
                // 0: Clear sky
            return WeatherSymbols.sunMaxFill.rawValue
                
            case 1, 2, 3:
                // Mainly clear, partly cloudy, and overcast
                return WeatherSymbols.cloudSunFill.rawValue
                
            case 45, 48:
                // Fog and depositing rime fog
                return WeatherSymbols.cloudFogFill.rawValue
                
            case 51, 53, 55:
                // Drizzle: Light, moderate, and dense intensity
                return WeatherSymbols.cloudDrizzleFill.rawValue
                
            case 56, 57:
                // Freezing Drizzle: Light and dense intensity
                return WeatherSymbols.cloudSleetFill.rawValue
                
            case 61, 63, 65:
                // Rain: Slight, moderate and heavy intensity
                return WeatherSymbols.cloudRainFill.rawValue
                
            case 66, 67:
                // Freezing Rain: Light and heavy intensity
                return WeatherSymbols.cloudRainFill.rawValue
                
            case 71, 73, 75:
                // Snow fall: Slight, moderate, and heavy intensity
                return WeatherSymbols.cloudSnowFill.rawValue
                
            case 77:
                // Snow grains
            return WeatherSymbols.snow.rawValue
                
            case 80, 81, 82:
                // Rain showers: Slight, moderate, and violent
                return WeatherSymbols.cloudHeavyRainFill.rawValue
                
            case 85, 86:
                // Snow showers slight and heavy
                return WeatherSymbols.cloudSnowFill.rawValue
                
            case 95:
                // Thunderstorm: Slight or moderate
                return WeatherSymbols.cloudboltFill.rawValue
                
            case 96, 99:
                // Thunderstorm with slight and heavy hail
                return WeatherSymbols.cloudboltRainFill.rawValue
                
            default:
                // Unknown weather code
                return WeatherSymbols.questionmark.rawValue
            }
    }
}
