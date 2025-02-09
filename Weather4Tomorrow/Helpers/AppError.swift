//
//  AppError.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 09.02.25.
//

import Foundation

enum AppError: Error {
    case geoCodingServiceError(GeocodingServiceError)
    case weatherServiceError(WeatherServiceError)
    case weatherViewModelError(WeatherViewModelError)
    
    var localizedDescription: String {
        switch self {
            case .geoCodingServiceError(let error):
            return error.localizedDescription
        case .weatherServiceError(let error):
            return error.localizedDescription
        case .weatherViewModelError(let error):
            return error.localizedDescription
        }
    }
    
    enum WeatherServiceError: Error {
        case failedToCreateURL
        case failedToFetchData
        case failedToExtractDataForcasts
        case receivedCorruptedData
        
        var localizedDescription: String {
            let description = "[Weather Service]"
            switch self {
            case .failedToCreateURL:
                return "\(description) Failed to create URL"
            case .failedToFetchData:
                return "\(description) Failed to fetch data"
            case .failedToExtractDataForcasts:
                return "\(description) Failed to extract data forcasts"
            case .receivedCorruptedData:
                return "\(description) Received corrupted data"
            }
        }
    }
    
    enum GeocodingServiceError: Error {
        case failedToFindPlacemark
        
        var localizedDescription: String {
            let description = "[Geocoding Service]"
            switch self {
            case .failedToFindPlacemark:
                return "\(description) Failed to find placemark"
            }
        }
    }
    
    enum WeatherViewModelError: Error {
        case failedToReceiveWeatherData
        case failedToReceiveCityName
        
        var localizedDescription: String {
            let description = "Oops, something went wrong during startUpdatingWeather method. Perhaps you need to check your internet connection or just ignore it and go for a walk, regardless of what the weather is like there"
            switch self {
            case .failedToReceiveCityName:
                return "[Geocoding Service] " + description
            case .failedToReceiveWeatherData:
                return "[Weather Service] " + description
            }
        }
    }
}
