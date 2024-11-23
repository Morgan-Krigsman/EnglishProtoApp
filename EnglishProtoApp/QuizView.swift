//
//  QuizView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import SwiftUI

struct QuizView: View {
    let level: Int // Include the level to customize background color
    var questions: [QuizQuestion]
    var onQuizCompleted: (Bool) -> Void

    @State private var currentQuestionIndex = 0
    @State private var selectedOption: String? = nil
    @State private var showResultAlert = false
    @State private var isCorrectAnswer = false
    @State private var correctAnswersCount = 0

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            // Question Counter
            Text("Question \(currentQuestionIndex + 1)/\(questions.count)")
                .font(.headline)
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding(.horizontal)

            // Question Text
            ScrollView {
                Text(questions[currentQuestionIndex].question)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .frame(maxHeight: 200) // Adjust as needed
            .padding(.horizontal)

            // Options
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    AudioManager.shared.playEffect(named: "optionSelect")
                }) {
                    HStack {
                        Spacer()
                        Text(option)
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedOption == option ? Color.green : Color.gray, lineWidth: 2)
                    )
                    .padding(.horizontal)
                }
                .disabled(selectedOption != nil && selectedOption != option)
            }

            // OK Button
            if selectedOption != nil {
                Button(action: {
                    checkAnswer()
                }) {
                    Text("OK")
                        .boldRoundedBrownText(size: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }

            Spacer()
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all)) // Set background color
        .alert(isPresented: $showResultAlert) {
            if currentQuestionIndex < questions.count - 1 {
                return Alert(
                    title: Text(isCorrectAnswer ? "That's right!" : "Try again"),
                    dismissButton: .default(Text("Next"), action: {
                        nextQuestion()
                    })
                )
            } else {
                // Last question answered, show final score
                return Alert(
                    title: Text("Quiz Completed"),
                    message: Text("You scored \(correctAnswersCount) out of \(questions.count)"),
                    dismissButton: .default(Text("OK"), action: {
                        let passed = Double(correctAnswersCount) / Double(questions.count) >= 0.8
                        onQuizCompleted(passed)
                        presentationMode.wrappedValue.dismiss()
                    })
                )
            }
        }
    }

    // Computed property for background color
    var backgroundColor: Color {
        if level == 2 {
            return Color(red: 245/255, green: 245/255, blue: 220/255) // Light beige
        } else {
            return Color.white
        }
    }

    func checkAnswer() {
        let question = questions[currentQuestionIndex]
        if selectedOption == question.correctAnswer {
            isCorrectAnswer = true
            correctAnswersCount += 1
            AudioManager.shared.playEffect(named: "correctAnswer")
        } else {
            isCorrectAnswer = false
            AudioManager.shared.playEffect(named: "wrongAnswer")
        }
        showResultAlert = true
    }

    func nextQuestion() {
        selectedOption = nil
        currentQuestionIndex += 1
        if currentQuestionIndex >= questions.count {
            // All questions completed
            showResultAlert = true
        }
    }
}
