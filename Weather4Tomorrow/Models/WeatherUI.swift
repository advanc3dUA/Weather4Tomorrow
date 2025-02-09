//
//  WeatherUI.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import Foundation

struct WeatherUI {
    let cityName: String
    let currentUI: CurrentUI
    let hourlyUI: [HourlyUI]
    let dailyUI: [DailyUI]
    
    struct CurrentUI {
        let dayOfTheWeek: String
        let temperature2m: Int
        let weatherIcon: String
    }
    
    struct HourlyUI: Hashable {
        let time: String
        let temperature2m: Int
        let weatherIcon: String
    }
    
    struct DailyUI: Hashable {
        let time: String
        let weatherIcon: String
        let temperature2mMin: Int
        let temperature2mMax: Int
    }
}

extension WeatherUI: Equatable {
    static func == (lhs: WeatherUI, rhs: WeatherUI) -> Bool {
        lhs.cityName == rhs.cityName
    }
}
