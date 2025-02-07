//
//  GeocodingServiceProtocol.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

protocol GeocodingServiceProtocol {
    func fetchCityName(latitude: Double, longitude: Double) async throws -> String
}
