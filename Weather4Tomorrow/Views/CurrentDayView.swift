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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: .white, radius: 10, x: 10)
                    .padding(.horizontal, 20)
                
                Text(currentWeather.dayOfTheWeek)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .shadow(color: .white, radius: 10, x: 10)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Text("\(currentWeather.temperature2m)°C")
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: .white, radius: 10, x: 10)
                    .padding(.horizontal, 20)
                
                Image(systemName: currentWeather.weatherIcon)
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: .white, radius: 10, x: 10)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300, alignment: .center)
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
