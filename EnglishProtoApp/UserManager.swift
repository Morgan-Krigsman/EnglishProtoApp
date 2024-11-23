//
//  UserManager.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import Foundation
import SwiftUI
import Combine

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var currentUser: User? {
        didSet {
            saveUser()
        }
    }

    private let userDefaultsKey = "currentUser"

    init() {
        loadUser()
    }

    func createUser(name: String) {
        currentUser = User(name: name)
    }

    func saveUser() {
        if let user = currentUser {
            do {
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.set(data, forKey: userDefaultsKey)
                print("User data saved. Unlocked levels: \(user.unlockedLevels)")
            } catch {
                print("Failed to save user: \(error)")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
            print("User data cleared.")
        }
    }

    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                currentUser = try JSONDecoder().decode(User.self, from: data)
                print("User data loaded. Unlocked levels: \(currentUser?.unlockedLevels ?? -1)")
            } catch {
                print("Failed to load user: \(error)")
                currentUser = nil
            }
        } else {
            currentUser = nil
            print("No user data found.")
        }
    }

    func incrementUnlockedLevels(currentLevel: Int) {
        if var user = currentUser {
            if user.unlockedLevels == currentLevel && user.unlockedLevels < 20 {
                user.unlockedLevels += 1
                currentUser = user // Reassign to trigger @Published
                // No need to call saveUser() here; didSet on currentUser handles it
            }
        }
    }

    func unlockAchievement(name: String) {
        if var user = currentUser {
            if !user.achievements.contains(where: { $0.name == name }) {
                if let achievement = AchievementsManager.shared.achievements.first(where: { $0.name == name }) {
                    user.achievements.append(achievement)
                    currentUser = user // Reassign to trigger @Published
                }
            }
        }
    }
}
