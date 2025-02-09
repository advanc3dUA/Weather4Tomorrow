//
//  CurrentDayView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct CurrentDayView: View {
    let cityName: String
    let currentWeather: WeatherUI.CurrentUI
    
    @State private var isSymbolAnimating = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cityName)
                    .modifier(LargeTextModifier())
                    .padding(.horizontal, 20)
                
                Text(currentWeather.dayOfTheWeek)
                    .modifier(MediumTextModifier())
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Text("\(currentWeather.temperature2m)°C")
                    .modifier(LargeTextModifier())
                    .padding(.horizontal, 20)
                
                Image(systemName: currentWeather.weatherIcon)
                    .renderingMode(.original)
                    .modifier(LargeTextModifier())
                    .scaleEffect(isSymbolAnimating ? 1.25 : 1.0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5).repeatCount(5, autoreverses: true)) {
                            isSymbolAnimating = true
                        }
                    }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .center)
    }
}

#Preview {
    CurrentDayView(cityName: "Someburg",
                   currentWeather: .init(
                    dayOfTheWeek: "Friday",
                    temperature2m: 25,
                    weatherIcon: WeatherSymbols.sunMaxFill.rawValue
                   )
    )
}
