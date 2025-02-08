//
//  RegularMaterialBackgroundView.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct RegularMaterialBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.regularMaterial)
    }
}

#Preview {
    UltraThinMaterialBackgroundView()
}
