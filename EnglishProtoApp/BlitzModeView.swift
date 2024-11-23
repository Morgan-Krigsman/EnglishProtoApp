//
//  BlitzModeView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 29.10.2024.
//

import SwiftUI

struct BlitzModeView: View {
    var body: some View {
        VStack {
            Text("Blitz Mode")
                .boldRoundedBrownText(size: 24)
                .padding()

            Spacer()

            Text("Blitz Mode is coming soon!")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.brown)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Blitz Mode", displayMode: .inline)
    }
}
