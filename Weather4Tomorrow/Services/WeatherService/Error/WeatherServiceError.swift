//
//  WeatherServiceError.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

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
