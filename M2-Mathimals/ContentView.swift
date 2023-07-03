//
//  ContentView.swift
//  M2-Mathimals
//
//  Created by Jonathan Tipton on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAskingQuestion = true
    @State private var questions = [(Int, Int, Int)]()
    @State private var currentQuestion = 0
    @State private var correctAnswerCount = 0
    @State private var animal = ""
    
    var body: some View {
        NavigationView {
            if isAskingQuestion {
                SettingsView(selectedAnimal: $animal, questions: $questions, isShown: $isAskingQuestion)
            } else {
                if currentQuestion < questions.count {
                    QuestionView(currentQuestion: $currentQuestion, question: $questions[currentQuestion], correctAnswerCount: $correctAnswerCount)
                } else {
                    VStack(spacing: 50) {
                        Image(animal, bundle: .main)
                        Text("End Game")
                        Text("You got \(correctAnswerCount)/\(questions.count) correct!")
                            .padding()
                            .multilineTextAlignment(.center)
                        Button("Play Again?") {
                            reset()
                        }
                    }
                    .navigationTitle("Game Over")
                    .font(.custom("Futura", size: 32))
                    .padding()
                }
            }
        }
        .transition(.opacity)
    }
    
    func reset() {
        animal = ""
        currentQuestion = 0
        correctAnswerCount = 0
        questions.removeAll()
        isAskingQuestion = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
