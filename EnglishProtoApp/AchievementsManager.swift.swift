//
//  AchievementsManager.swift.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import Foundation

class AchievementsManager: ObservableObject {
    static let shared = AchievementsManager()

    @Published var achievements: [Achievement] = [
        Achievement(name: "First Steps", description: "Complete Level 1"),
        Achievement(name: "Halfway There", description: "Reach Level 10"),
        Achievement(name: "Master", description: "Complete all levels")
    ]
}
