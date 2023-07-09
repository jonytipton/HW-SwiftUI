//
//  Adding_strokeBorder.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/8/23.
//

import SwiftUI

struct InsetArc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
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

struct Adding_strokeBorder: View {
    
    var body: some View {
        //Circle()
        //    .strokeBorder(.blue, lineWidth: 40)
        InsetArc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 50)
    }
}

struct Adding_strokeBorder_Previews: PreviewProvider {
    static var previews: some View {
        Adding_strokeBorder()
    }
}
