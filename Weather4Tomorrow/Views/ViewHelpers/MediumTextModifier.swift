//
//  MediumTextModifier.swift
//  Weather4Tomorrow
//
//  Created by Yuriy Gudimov on 08.02.25.
//

import SwiftUI

struct MediumTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.semibold)
            .shadow(color: .white, radius: 10, x: 10)
    }
}
