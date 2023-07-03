//
//  QuestionView.swift
//  C1-Edutainment
//
//  Created by Jonathan Tipton on 7/1/23.
//

import SwiftUI

struct QuestionView: View {
    @Binding var currentQuestion: Int
    @Binding var question: (Int, Int, Int)
    @Binding var correctAnswerCount: Int
    
    @State private var answer = ""
    @State private var showAlert = false
    
    @FocusState private var textfieldIsFocused: Bool

    var body: some View {
        VStack(spacing: 25) {
            Spacer()
                Text("\(question.0)")
                .foregroundStyle(.purple)
                Image(systemName: "multiply")
                .fontWeight(.bold)

                Text("\(question.1)")
                .foregroundStyle(.cyan)
            
                Image(systemName: "equal")
                .fontWeight(.bold)

            TextField("?", text: $answer) {
                }
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .foregroundStyle(.mint)
            .focused($textfieldIsFocused)

                Button("Next") {
                    guard answer != "" else { showAlert = true; return }
                    if question.2 == Int(answer) {
                        correctAnswerCount += 1
                    }
                    withAnimation {
                        currentQuestion += 1
                        answer = ""
                    }
                }
            Spacer()
            }
        .padding()
        .font(.custom("Futura", size: 42))
        .fontWeight(.bold)
        .alert("Uh Oh!", isPresented: $showAlert, actions: {
            Button("OK") { showAlert = false }
        }, message: {
            Text("You forgot an answer!")
        })
            .navigationTitle("Question \(currentQuestion + 1)")
            .onAppear {
                textfieldIsFocused = true
            }
    }
}
