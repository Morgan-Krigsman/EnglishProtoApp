//
//  User.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var unlockedLevels: Int
    var achievements: [Achievement]

    init(id: UUID = UUID(), name: String, unlockedLevels: Int = 1, achievements: [Achievement] = []) {
        self.id = id
        self.name = name
        self.unlockedLevels = unlockedLevels
        self.achievements = achievements
    }
}
