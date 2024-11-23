//
//  QuizQuestion.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: String
}
