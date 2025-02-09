//
//  LoadingView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 09.02.25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.loadingBackgroud
                .ignoresSafeArea()
            
            Text("Loading...")
                .foregroundStyle(.white)
                .modifier(MediumTextModifier())
        }
    }
}

#Preview {
    LoadingView()
}
