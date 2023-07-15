//
//  RingView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/12/23.
//

import SwiftUI

struct RingView: View {
    
    @Binding var totalHabits: Int
    
    @Binding var completedHabits: Int
    @State private var percentComplete: Double = 0.0
    @State private var completedAllHabits: Bool = false
    @State private var iconScale: Double = 0.1
    @State private var resetDegrees: Double = 0.0
    
    let ringWidth = 40.0
    
    var spinCount: Int = 10
    var resetSpinCount: Int = 1
    var spinSpeed: Double = 1.75
    var arcEndAngle: Double {
        return 360
    }
    
    //Animations
    private var rotationEffect: Animation {
        .easeInOut(duration: 10)
        .speed(spinSpeed)
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Text("Habits Remaining")
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Text("\(totalHabits - completedHabits)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.mint)
                }
                ZStack {
                    RingShape()
                        .stroke(AngularGradient(
                            gradient: Gradient(colors: [.mint.opacity(0.1)]),
                            center: .center,
                            startAngle: .degrees(-180),
                            endAngle: .degrees(360 - 90)),
                                style: StrokeStyle(lineWidth: ringWidth, lineCap: .round))
                        .shadow(color: .mint.opacity(0.1), radius: 5, x: 0, y: 0)
                    
                    RingShape()
                        .trim(from: 0, to: percentComplete > 0 ? percentComplete : 0)
                        .stroke(AngularGradient(
                            gradient: Gradient(colors: [.mint, .cyan]),
                            center: .center,
                            startAngle: .degrees(-90),
                            endAngle: .degrees(360 - 90)),
                                style: StrokeStyle(lineWidth: ringWidth, lineCap: .round, lineJoin: .round))
                        .animation(.spring(dampingFraction: 0.75), value: percentComplete)
                        .shadow(color: .black, radius: 1, x: 0, y: 0)
                    
                    //Ring Endcap
                    RingShape()
                        .fill(completedAllHabits ? .cyan : .mint)
                        .shadow(color: completedAllHabits ? .black.opacity(0.25) : .clear, radius: 2, x: 5, y: 0)
                        .overlay (
                            //IDEA: habit categories w/ matching icon for ring
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundStyle(.white)
                                .shadow(radius: 2, x: 2.5, y: 0.5)
                                .scaleEffect(iconScale, anchor: completedAllHabits ? .leading : .center)
                                .onAppear {
                                    withAnimation(.spring(dampingFraction: 0.25).delay(0.1)) {
                                        iconScale = 1.25
                                    }
                                }
                                .animation(Animation.interpolatingSpring(mass: 1, stiffness: 170, damping: 8, initialVelocity: 100).delay(3), value: completedAllHabits)
                        )
                        .frame(width: ringWidth, height: ringWidth)
                    //Get radius of ring for circle cap covering start/end of ring (otherwise split gradient of .white/.cyan appears for <100% completion
                        .offset(y: -(geo.size.height / 2))
                }
                .onAppear {
                    withAnimation {
                        percentComplete = Double(completedHabits) / Double(totalHabits)
                        
                        if percentComplete == 1.0 && totalHabits > 0 {
                            completedAllHabits = true
                        } else {
                            completedAllHabits = false
                        }
                        
//                        //for testing
//                        if percentComplete > 1.0 {
//                            resetProgress()
//                        }
                    }
                }
                .onChange(of: completedHabits) { _ in
                    withAnimation {
                        percentComplete = Double(completedHabits) / Double(totalHabits)

                        if percentComplete == 1.0 && totalHabits > 0 {
                            completedAllHabits = true
                        } else {
                            completedAllHabits = false
                        }
                        
//                        //for testing
//                        if percentComplete > 1.0 {
//                            resetProgress()
//                        }
                    }
                }
                .onChange(of: totalHabits) { _ in
                    withAnimation {
                        percentComplete = Double(completedHabits) / Double(totalHabits)
                        
                        if percentComplete == 1.0 && totalHabits > 0 {
                            completedAllHabits = true
                        } else {
                            completedAllHabits = false
                        }
                    }
                }
                .rotationEffect(completedAllHabits ? Angle(degrees: Double(360 * spinCount)) : Angle(degrees: resetDegrees))
                .animation(rotationEffect.speed(spinSpeed), value: completedAllHabits)
            }
        }
    }
    
//    func resetProgress() {
//        completedHabits = 0
//        completedAllHabits = false
//    }
}

struct RingView_Previews: PreviewProvider {
    @State static var habits = 5
    @State static var completed = 0
    static var previews: some View {
        RingView(totalHabits: $habits, completedHabits: $completed)
    }
}
