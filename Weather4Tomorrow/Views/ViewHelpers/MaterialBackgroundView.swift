//
//  MaterialBackgroundView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct MaterialBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .background(.ultraThinMaterial)
            .modifier(GradientStrokeBorderModifier())
            .padding()
    }
}

#Preview {
    MaterialBackgroundView()
}
