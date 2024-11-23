//
//  Modifiers.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct BoldRoundedBrownText: ViewModifier {
    var size: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(.brown)
    }
}

extension View {
    func boldRoundedBrownText(size: CGFloat) -> some View {
        self.modifier(BoldRoundedBrownText(size: size))
    }
}
