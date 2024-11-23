//
//  AchievementsView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var userManager = UserManager.shared

    var body: some View {
        List {
            if let user = userManager.currentUser {
                ForEach(AchievementsManager.shared.achievements) { achievement in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(achievement.name)
                                .font(.headline)
                            Text(achievement.description)
                                .font(.subheadline)
                        }
                        Spacer()
                        Image(systemName: user.achievements.contains(achievement) ? "checkmark.seal.fill" : "seal")
                            .foregroundColor(user.achievements.contains(achievement) ? .green : .gray)
                    }
                    .padding()
                }
            } else {
                Text("No user data available.")
            }
        }
        .navigationBarTitle("Achievements", displayMode: .inline)
    }
}
