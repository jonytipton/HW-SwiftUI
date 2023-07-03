//
//  SettingsView.swift
//  M2-Mathimals
//
//  Created by Jonathan Tipton on 7/1/23.
//

import SwiftUI

struct SettingsView: View {
    
    var animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe"]
    @Binding var selectedAnimal: String
    @State private var difficulty = 2
    var questionCount = [5, 10, 15, 20]
    var difficultyList = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @State private var selectedQuestionCount: Int = 5
    @Binding var questions: [(Int, Int, Int)]
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 50) {
                Text("Difficulty")
                    .font(.custom("Futura", size: 32))
                HStack(spacing: 50) {
                    Image(animals[difficulty - 2], bundle: .main)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .id(animals[difficulty - 2])
                        .transition(.opacity.animation(.default))
                    Picker("Pick a number", selection: $difficulty) {
                        ForEach(difficultyList, id: \.self) { num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding([.leading, .trailing])
                    .scaleEffect(x: 2, y: 2)
                    .frame(width: 100, height: 100)
                }
                .frame(height: 150)
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                Text("Question Count")
                    .font(.custom("Futura", size: 32))
                
                Picker("Pick a number", selection: $selectedQuestionCount) {
                    ForEach(questionCount, id: \.self) { num in
                        Text("\(num)")
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            Spacer()
            Button("Start") {
                createQuestions()
            }
            .buttonStyle(.borderedProminent)
                .tint(.green) 
            .font(.largeTitle)
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("Mathimals")
    }
    
    func createQuestions() {
        questions.removeAll()
        selectedAnimal = animals[difficulty - 2]
        for num in 1...selectedQuestionCount {
            questions.append((difficulty, num, (difficulty * num)))
        }
        questions.shuffle()
        print(questions)
        isShown = false
    }
}
