//
//  RingShape.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/12/23.
//

import Foundation
import SwiftUI

struct RingShape: Shape {
    var percentage: Double = 100
    var startAngle: Double = -90
    var isClockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let height = rect.height
        let width = rect.width
        let center = CGPoint(x: width / 2, y: height / 2)
        
        var path = Path()
        
        path.addArc(center: center, radius: min(rect.width / 2, rect.height / 2), startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: 360 * (percentage / 100) - abs(startAngle)), clockwise: isClockwise)
        
        return path
    }
    
    
    
}
