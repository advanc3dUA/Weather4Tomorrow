//
//  OverlayView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 09.02.25.
//

import SwiftUI

struct OverlayView: View {
    let text: String
    
    var body: some View {
        ZStack {
            Color.overlayBackground
                .ignoresSafeArea()
            
            Text(text)
                .foregroundStyle(.white)
                .modifier(MediumTextModifier())
                .lineLimit(.none)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    OverlayView(text: "Loading...")
}
