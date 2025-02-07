//
//  WeatherServiceProtocol.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchData(latitude: Double, longitude: Double) async throws -> WeatherData
}
