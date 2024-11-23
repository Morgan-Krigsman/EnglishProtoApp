//
//  AudioManager.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    var musicPlayer: AVAudioPlayer?
    var effectsPlayer: AVAudioPlayer?

    @AppStorage("musicVolume") var musicVolume: Double = 0.5
    @AppStorage("effectsVolume") var effectsVolume: Double = 0.5

    private init() {
        // Load and prepare background music
        if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.volume = Float(musicVolume)
                musicPlayer?.play()
                print("Background music started.")
            } catch {
                print("Error loading music file: \(error.localizedDescription)")
            }
        }
    }

    func updateMusicVolume() {
        musicPlayer?.volume = Float(musicVolume)
    }

    func updateEffectsVolume() {
        effectsPlayer?.volume = Float(effectsVolume)
    }

    func playEffect(named effectName: String) {
        if let effectURL = Bundle.main.url(forResource: effectName, withExtension: "mp3") {
            do {
                effectsPlayer = try AVAudioPlayer(contentsOf: effectURL)
                effectsPlayer?.volume = Float(effectsVolume)
                effectsPlayer?.play()
                print("Playing effect: \(effectName)")
            } catch {
                print("Error loading effect file: \(error.localizedDescription)")
            }
        } else {
            print("Sound effect \(effectName) not found")
        }
    }
}
