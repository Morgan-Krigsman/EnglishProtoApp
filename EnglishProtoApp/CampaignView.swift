//
//  CampaignView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import SwiftUI

struct CampaignView: View {
    @ObservedObject var userManager = UserManager.shared

    var body: some View {
        if let user = userManager.currentUser {
            List(1...20, id: \.self) { level in
                if level <= user.unlockedLevels {
                    NavigationLink(destination: LevelView(level: level)) {
                        Text("Level \(level)")
                            .boldRoundedBrownText(size: 20)
                    }
                } else {
                    Text("Level \(level)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Campaign", displayMode: .inline)
        } else {
            Text("No user data available.")
        }
    }
}
