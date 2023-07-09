//
//  MetalRenderingWith_drawingGroup.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/9/23.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
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

struct MetalRenderingWith_drawingGroup: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct MetalRenderingWith_drawingGroup_Previews: PreviewProvider {
    static var previews: some View {
        MetalRenderingWith_drawingGroup()
    }
}
