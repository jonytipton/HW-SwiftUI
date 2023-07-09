//
//  AnimatingComplexShapes.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/9/23.
//

import SwiftUI

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(Double(rows), Double(columns)) }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for col in 0..<columns {
                if (row + col).isMultiple(of: 2) {
                    let startX = columnSize * Double(col)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct AnimatingComplexShapes: View {
    @State private var rows = 4
    @State private var cols = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: cols)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    cols = 16
                }
            }
    }
}

struct AnimatingComplexShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingComplexShapes()
    }
}
