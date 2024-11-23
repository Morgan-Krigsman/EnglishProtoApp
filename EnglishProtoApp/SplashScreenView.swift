//
//  SplashScreenView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var floatUp = false
    @State private var opacity = 1.0

    var body: some View {
        if isActive {
            MainMenuView()
                .transition(.opacity)
        } else {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    Image("gameLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(y: floatUp ? -10 : 10)
                        .animation(
                            Animation.easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true),
                            value: floatUp
                        )
                        .onAppear {
                            self.floatUp.toggle()
                        }
                        .opacity(opacity)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isActive = true
                }
            }
        }
    }
}
