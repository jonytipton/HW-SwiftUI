//
//  InsetArc.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/11/23.
//

import SwiftUI

struct InsetArc: InsettableShape {
    let startAngle: Angle
    var endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        //Shapes draw from bottom left (Core Graphics)
        //SwiftUI draws from top left (~UIKit)
        //.zero degrees is not vertical up/down, points right along x-axis (mathematics)
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct InsetArc_Previews: PreviewProvider {
    static var startAngle: Angle = .degrees(0)
    static var endAngle: Angle = .degrees(180)
    static var isClockwise: Bool = true
    
    static var previews: some View {
        ZStack {
            Text("10")
                .font(.largeTitle)
            InsetArc(startAngle: startAngle, endAngle: endAngle, clockwise: isClockwise)
                .strokeBorder(.blue, lineWidth: 50)
        }
        
    }
}
