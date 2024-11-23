//
//  SettingsView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var audioManager = AudioManager.shared

    var body: some View {
        Form {
            Section(header: Text("Music Volume")) {
                Slider(value: $audioManager.musicVolume, in: 0...1)
                    .onChange(of: audioManager.musicVolume) { oldValue, newValue in
                        audioManager.updateMusicVolume()
                    }
            }

            Section(header: Text("Effects Volume")) {
                Slider(value: $audioManager.effectsVolume, in: 0...1)
                    .onChange(of: audioManager.effectsVolume) { oldValue, newValue in
                        audioManager.updateEffectsVolume()
                    }
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
    }
}
