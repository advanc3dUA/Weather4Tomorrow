//
//  HourlyView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct Next24HoursView: View {
    let hourlyData: [WeatherUI.HourlyUI]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(hourlyData, id: \.self) { hourData in
                    HourView(hourData: hourData)
                }
            }
            .padding(.all, 5)
        }
    }
}

#Preview {
    Next24HoursView(
        hourlyData:
            [
            .init(time: "11:00", temperature2m: 25, weatherIcon: WeatherSymbols.cloudRainFill.rawValue),
            .init(time: "12:00", temperature2m: 15, weatherIcon: WeatherSymbols.cloudRainFill.rawValue),
            .init(time: "13:00", temperature2m: -25, weatherIcon: WeatherSymbols.cloudRainFill.rawValue),
            .init(time: "14:00", temperature2m: 2, weatherIcon: WeatherSymbols.cloudRainFill.rawValue),
            .init(time: "14:00", temperature2m: 25, weatherIcon: WeatherSymbols.cloudRainFill.rawValue),
            .init(time: "15:00", temperature2m: 10, weatherIcon: WeatherSymbols.cloudRainFill.rawValue)
        ]
    )
}
