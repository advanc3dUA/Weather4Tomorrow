//
//  HourView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct HourView: View {
    let hourData: WeatherUI.HourlyUI
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(hourData.time)
                .modifier(SmallTextModifier())
                .foregroundStyle(.secondary)
            
            Text("\(hourData.temperature2m)°C")
                .modifier(MediumTextModifier())
            
            Image(systemName: hourData.weatherIcon)
                .renderingMode(.original)
                .modifier(MediumTextModifier())
        }
        .frame(minWidth: 50)
        .padding()
        .background(RegularMaterialBackgroundView().opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    HourView(hourData: .init(time: "11:00", temperature2m: 15, weatherIcon: WeatherSymbols.cloudDrizzleFill.rawValue))
}
