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
}
