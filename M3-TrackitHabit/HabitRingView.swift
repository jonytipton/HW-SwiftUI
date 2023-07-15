//
//  HabitRingView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/11/23.
//

import SwiftUI

struct HabitRingView: View {
    @State private var habitCount: Int
    @State private var completedCount: Int
    @State private var show = false
    @State private var stop = 0.0
    
    var percentComplete: Double = 0.0
    
    var arcStartAngle: Angle = .zero
    var arcEndAngle: Angle {
            let ratio = Double(completedCount) / Double(habitCount)
        let angle: Angle = .degrees(360.0 * ratio)
        return angle
    }
    
    var body: some View {
        ZStack {
                InsetArc(startAngle: .zero, endAngle: .degrees(360), clockwise: true)
                    .inset(by: 30)
                    .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), style: StrokeStyle(lineWidth: 40, lineCap: .round))
                
            InsetArc(startAngle: arcStartAngle, endAngle: arcEndAngle, clockwise: true)
                    .inset(by: 30)
                    .trim(from: show ? 1/8 : 1, to: 0.9)
                    .stroke(AngularGradient(
                        gradient: Gradient(colors: [.clear, .mint]),
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: arcEndAngle - .degrees(90)),
                            style: StrokeStyle(lineWidth: 40, lineCap: .round))
                    .shadow(color: .mint.opacity(0.5), radius: 10, x: 0, y: 0)
                    .animation(Animation.easeIn(duration: 1), value: show)
                    .onAppear {
                        show.toggle()
                        withAnimation {
                            stop = 1
                        }
                    }
            VStack {
                Text("Habits Remaining")
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Text("\(habitCount - completedCount)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.mint)
            }
        }
        .padding()
        .onTapGesture {
                completedCount += 1        }
    }
    
    init(habitCount: Int, completedCount: Int) {
        self.habitCount = habitCount
        self.completedCount = completedCount
    }
}

struct HabitRingView_Previews: PreviewProvider {
    static var habitCount = 10
    static var completedCount = 0
    static var previews: some View {
        HabitRingView(habitCount: habitCount, completedCount: completedCount)
    }
}
