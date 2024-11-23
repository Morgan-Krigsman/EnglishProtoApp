//
//  ProfileCreationView.swift.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct ProfileCreationView: View {
    @State private var name = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Create Profile")
                .font(.largeTitle)
                .padding()

            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if !name.isEmpty {
                    UserManager.shared.createUser(name: name)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Create")
                    .boldRoundedBrownText(size: 20)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.lightBrown)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
    }
}
