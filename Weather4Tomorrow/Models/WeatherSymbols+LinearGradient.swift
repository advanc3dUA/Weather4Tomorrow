//
//  WeatherSymbols+LinearGradient.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

extension WeatherSymbols {
    var gradient: LinearGradient {
        switch self {
        case .sunMaxFill:
            // A warm, delicate gradient for clear sky
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.95, blue: 0.7), // soft yellow
                    Color(red: 1.0, green: 0.8, blue: 0.4)   // gentle orange
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudSunFill:
            // A light blue gradient for partly cloudy
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.9, green: 0.95, blue: 1.0), // very light blue
                    Color(red: 0.7, green: 0.85, blue: 1.0)  // soft blue
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudFogFill:
            // A delicate grey gradient for foggy conditions
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.9, green: 0.9, blue: 0.9),  // light grey
                    Color(red: 0.8, green: 0.8, blue: 0.8)   // medium grey
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudDrizzleFill:
            // A soft blue gradient for drizzle
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.8, green: 0.85, blue: 0.95),
                    Color(red: 0.6, green: 0.7, blue: 0.9)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudSleetFill:
            // Similar to drizzle, but you could adjust the tint if desired
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.75, green: 0.8, blue: 0.9),
                    Color(red: 0.55, green: 0.6, blue: 0.85)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudRainFill:
            // A deeper blue gradient for rain
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.65, green: 0.75, blue: 0.9),
                    Color(red: 0.45, green: 0.55, blue: 0.85)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudSnowFill:
            // A very light, almost wintry blue/grey gradient for snow
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.95, blue: 1.0),
                    Color(red: 0.85, green: 0.85, blue: 0.95)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudboltFill:
            // A slightly dark, mysterious purple gradient for a thunderstorm
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.8, green: 0.7, blue: 0.85),
                    Color(red: 0.6, green: 0.5, blue: 0.75)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudboltRainFill:
            // A gradient with a mix of stormy purple and blue for thunderstorms with rain
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.7, green: 0.6, blue: 0.85),
                    Color(red: 0.5, green: 0.4, blue: 0.75)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .cloudHeavyRainFill:
            // A slightly more intense blue for heavy rain, yet kept delicate
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.6, green: 0.65, blue: 0.85),
                    Color(red: 0.4, green: 0.45, blue: 0.75)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .snow:
            // A crisp, soft white to light blue gradient for snowy conditions
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.98, green: 0.98, blue: 1.0),
                    Color(red: 0.88, green: 0.88, blue: 0.95)
                ]),
                startPoint: .top,
                endPoint: .bottom)
            
        case .questionmark:
            // A neutral gradient for unknown conditions
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color.gray.opacity(0.5),
                    Color.gray.opacity(0.7)
                ]),
                startPoint: .top,
                endPoint: .bottom)
        }
    }
}
