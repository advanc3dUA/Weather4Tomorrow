//
//  WeatherUI+backgroundGradient.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

extension WeatherUI {
    var backgroundGradient: LinearGradient {
        if let symbol = WeatherSymbols(rawValue: self.currentUI.weatherIcon) {
            return symbol.gradient
        } else {
            return WeatherSymbols.questionmark.gradient
        }
    }
}
