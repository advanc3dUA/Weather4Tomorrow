//
//  GeocodingService.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import CoreLocation

class GeocodingService: GeocodingServiceProtocol {
    private let geocoder = CLGeocoder()
        
    func fetchCityName(latitude: Double, longitude: Double) async throws -> String {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        return try await withCheckedThrowingContinuation { continuation in
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let placemark = placemarks?.first, let city = placemark.locality {
                    placemarks?.forEach({ placemark in
                        print(placemark)
                    })
                    continuation.resume(returning: city)
                } else {
                    continuation.resume(throwing: GeocodingServiceError.failedToFindPlacemark)
                }
            }
        }
    }
}
