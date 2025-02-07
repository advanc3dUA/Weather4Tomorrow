//
//  ContentView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 07.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await WeatherService.fetchData(latitude: 53.619653, longitude: 10.079969)
            }
        }
    }
}

#Preview {
    ContentView()
}
