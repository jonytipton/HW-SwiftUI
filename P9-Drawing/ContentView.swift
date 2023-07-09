//
//  ContentView.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/8/23.
//

import SwiftUI

struct ColorCyclingRect: View {
    var amount: Double
    var steps: Double
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(amount, steps)}
        set {
            amount = newValue.first
            steps = newValue.second
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<Int(steps), id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                //.strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                
                //This will be slow, rendering 100s of gradients over 100 views
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1),
                        color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        //Use this to render with metal, image rendered off screen then displayed - much faster than CoreAnimation
        //This may slow down SwiftUI when used for simple drawings, only use when encountering performance issues
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: Shape {
    var width: CGFloat
    var height: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(width, height)}
        set {
            width = newValue.first
            height = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX - width, y: rect.midY + height))
        path.addLine(to: CGPoint(x: rect.midX + width, y: rect.midY + height))
        path.addLine(to: CGPoint(x: rect.midX + width, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - width / 2.0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + height))
        path.addLine(to: CGPoint(x: rect.minX + width / 2.0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - width, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
}

struct ContentView: View {
    @State private var width = 50.0
    @State private var height = 100.0
    @State private var amount = 10.0
    
    @State private var rectAmount = 1.0
    @State private var rectSteps = 100.0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ZStack {
                    Arrow(width: width, height: height)
                        .fill(.orange)
                        .frame(width: 300, height: 300)
                    
                    Arrow(width: width, height: height)
                        .stroke(.red, style: StrokeStyle(lineWidth: amount, lineCap: .round, lineJoin: .round))
                        .frame(width: 300, height: 300)
                }
                .onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        width = Double.random(in: 5...100)
                        height = Double.random(in: 5...100)
                    }
                }
                .padding(.top)
                
                HStack {
                    Text("Width")
                    Slider(value: $width, in: 50...100)
                }
                
                HStack {
                    Text("Height")
                    Slider(value: $height, in: 10...100)
                }
            }
            .padding()
            
            VStack {
                ColorCyclingRect(amount: rectAmount, steps: rectSteps)
                    .transition(AnyTransition.opacity)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.5)) {
                            rectSteps = Double.random(in: 10...200)
                            rectAmount = Double.random(in: 0...1)
                        }
                    }
                HStack {
                    Text("Hue")
                    Slider(value: $rectAmount)
                }
                
                HStack {
                    Text("Steps")
                    Slider(value: $rectSteps.animation(.easeIn), in: 1...200)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
