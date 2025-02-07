//
//  WeatherData.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import Foundation

struct WeatherData {
    let current: Current
    let hourly: Hourly
    let daily: Daily

    struct Current {
        let time: Date
        let temperature2m: Float
        let weatherCode: Float
    }

    struct Hourly {
        let time: [Date]
        let temperature2m: [Float]
        let weatherCode: [Float]
    }

    struct Daily {
        let time: [Date]
        let weatherCode: [Float]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
    }
}
