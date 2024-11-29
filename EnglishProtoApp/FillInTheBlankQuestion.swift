//
//  FillInTheBlankQuestion.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 23.10.2024.
//

import Foundation

struct FillInTheBlankQuestion: Identifiable {
    let id = UUID()
    let sentence: String 
    let correctWord: String
}
