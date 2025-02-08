//
//  Next7DaysView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct Next7DaysView: View {
    let daysData: [WeatherUI.DailyUI]
    
    var body: some View {
            VStack(alignment: .center, spacing: 5) {
                ForEach(daysData, id: \.self) { dayData in
                    DayView(dayData: dayData)
                }
        }
            .padding(.all, 5)
    }
}

#Preview {
    Next7DaysView(daysData: [
        .init(time: "01/02", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: -5, temperature2mMax: 5),
        .init(time: "01/03", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: -2, temperature2mMax: 5),
        .init(time: "01/04", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: 1, temperature2mMax: 10),
        .init(time: "01/05", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: 3, temperature2mMax: 8),
        .init(time: "01/06", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: 23, temperature2mMax: 25),
        .init(time: "01/07", weatherIcon: WeatherSymbols.sunMaxFill.rawValue, temperature2mMin: 25, temperature2mMax: 27)
    ])
}
