//
//  DayView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct DayView: View {
    let dayData: WeatherUI.DailyUI
    
    var body: some View {
        HStack(alignment: .center) {
            Text(dayData.time)
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(dayData.temperature2mMin)°C / \(dayData.temperature2mMax)°C")
            Spacer()
            Image(systemName: dayData.weatherIcon)
                .renderingMode(.original)
        }
        .modifier(SmallTextModifier())
        .padding()
        .background(RegularMaterialBackgroundView().opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
}

#Preview {
    DayView(dayData: .init(time: "01/02",
                           weatherIcon: WeatherSymbols.cloudSleetFill.rawValue,
                           temperature2mMin: 5,
                           temperature2mMax: 10)
    )
}
