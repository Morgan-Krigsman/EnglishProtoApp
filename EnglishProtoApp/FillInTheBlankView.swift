//
//  FillInTheBlankView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct FillInTheBlankView: View {
    let questions: [FillInTheBlankQuestion]
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var score = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)

            Text(questions[currentQuestionIndex].sentence)
                .font(.title2)
                .padding()

            TextField("Your answer", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                checkAnswer()
            }) {
                Text("Submit")
                    .boldRoundedBrownText(size: 20)
                    .padding()
                    .background(Color.lightBrown)
                    .cornerRadius(10)
            }
            // **Insert Image Here**
                        Image("imageName")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding()

            Spacer()
        }
        
        .alert(isPresented: $showResult) {
            Alert(
                title: Text("Result"),
                message: Text(userAnswer.lowercased() == questions[currentQuestionIndex].correctWord.lowercased() ? "Correct!" : "Incorrect"),
                dismissButton: .default(Text("Next"), action: {
                    moveToNextQuestion()
                })
            )
        }
    }

    func checkAnswer() {
        if userAnswer.lowercased() == questions[currentQuestionIndex].correctWord.lowercased() {
            score += 1
        }
        showResult = true
    }

    func moveToNextQuestion() {
        userAnswer = ""
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            // Activity completed
            // Handle completion (e.g., show final score)
        }
    }
}

struct FillInTheBlankView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleQuestions = [
            FillInTheBlankQuestion(sentence: "The cat sat on the ___", correctWord: "mat"),
            FillInTheBlankQuestion(sentence: "She sells ___ by the seashore", correctWord: "seashells")
        ]
        FillInTheBlankView(questions: sampleQuestions)
    }
}
