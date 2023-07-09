//
//  CreatingCustomPaths.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/8/23.
//

import SwiftUI

struct CreatingCustomPaths: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y:100))
            path.addLine(to: CGPoint(x:100, y:300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            //ask swiftUI to close the subpath
            //path.closeSubpath()
        }
        //use this isntead of closeSubpath for more customization
        .stroke(.blue, style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
    }
}

struct CreatingCustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CreatingCustomPaths()
    }
}
