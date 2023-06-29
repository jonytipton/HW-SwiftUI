//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jonathan Tipton on 6/24/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagView: View {
    var flag: String
    
    var body: some View {
        Image(flag)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    @State private var playCount = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.75, green: 0.15, blue: 0.26), location: 0.3)]
                               , center: .top, startRadius: geometry.size.height * 0.05, endRadius: geometry.size.width * 1.5)
                VStack() {
                    Spacer()
                    VStack() {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.custom("Futura", fixedSize: 35.0))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.custom("Futura", fixedSize: 35.0))
                            .underline()
                    }
                    
                    Spacer()
                    ForEach(0..<3) { number in
                        Spacer()
                        Button() {
                            flagTapped(number)
                        } label: {
                            FlagView(flag: countries[number])
                        }
                    }
                    .shadow(color: .black.opacity(0.75), radius: 10, x: 10, y: 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .stroke(Color.black, style: StrokeStyle(lineWidth: 5))
                    )
                    Spacer()
                    Text("Your Score: \(scoreValue)")
                        .titleStyle()
                    Spacer()
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(scoreValue)")
            }
            .alert("Game Over! Your score is \(scoreValue)", isPresented: $showingGameOver) {
                Button("Replay", action: restartGame)
                Button("Cancel") { }
            } message: {
                Text("Want to play again?")
            }
        }
        .ignoresSafeArea()
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreValue += 1
        } else {
            scoreTitle = "Wrong: That's the flag of \(countries[number])"
            scoreValue -= 1
        }
        
        showingScore = true
        playCount += 1
        
        if (playCount > 7) {
            showingGameOver = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        showingGameOver = false
        scoreValue = 0
        showingScore = false
        playCount = 0
        countries.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

    }
}
