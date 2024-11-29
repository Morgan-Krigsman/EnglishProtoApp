//
//  ProgressReportView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct ProgressReportView: View {
    @ObservedObject var userManager = UserManager.shared

    var body: some View {
        VStack {
            Text("Your Progress")
                .font(.title)
                .padding()

            if let user = userManager.currentUser {
                Text("Levels Completed: \(user.unlockedLevels - 1) / 20")
                    .font(.headline)
                    .padding()

            } else {
                Text("No user data available.")
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Progress Report", displayMode: .inline)
    }
}
