//
//  ContentView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var userManager = UserManager.shared
    @State private var showProfileCreation = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // User Greeting Box
                if let user = userManager.currentUser {
                    Text("Hello, \(user.name)!")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.brown)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.brown, lineWidth: 2)
                        )
                        .padding(.horizontal)
                }

                // Spacer to separate greeting from buttons
                Spacer().frame(height: 10)

                // Campaign Button
                NavigationLink(destination: CampaignView()) {
                    Text("Campaign")
                        .boldRoundedBrownText(size: 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Blitz Mode Button (Placeholder)
                NavigationLink(destination: BlitzModeView()) {
                    Text("Blitz Mode")
                        .boldRoundedBrownText(size: 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Achievements Button
                NavigationLink(destination: AchievementsView()) {
                    Text("Achievements")
                        .boldRoundedBrownText(size: 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Progress Report Button
                NavigationLink(destination: ProgressReportView()) {
                    Text("Progress Report")
                        .boldRoundedBrownText(size: 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Settings Button moved to the bottom
                NavigationLink(destination: SettingsView()) {
                    Text("Settings")
                        .boldRoundedBrownText(size: 24)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20) // Add some space above the settings button

                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("Main Menu", displayMode: .inline)
        }
        .onAppear {
            DispatchQueue.main.async {
                if userManager.currentUser == nil {
                    showProfileCreation = true
                }
            }
        }
        .sheet(isPresented: $showProfileCreation) {
            ProfileCreationView()
        }
    }
}
