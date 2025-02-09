//
//  SmallTextModifier.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct SmallTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.light)
            .shadow(color: .black.opacity(0.15), radius: 2, x: 2, y: 2)
    }
}
