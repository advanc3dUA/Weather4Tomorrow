//
//  GeocodingServiceError.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

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
