//
//  ImagePaintDrawing.swift
//  P9-Drawing
//
//  Created by Jonathan Tipton on 7/9/23.
//

import SwiftUI

struct ImagePaintDrawing: View {
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            //.frame(width: 300, height: 300)
            ////.border(.red, width: 30)
            //.border(ImagePaint(image: Image("Example"),sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.85), scale: 0.2), width: 50)
        
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"),sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.85), scale: 0.2), lineWidth: 25)
            .frame(width: 300, height: 200)
    }
}

struct ImagePaintDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintDrawing()
    }
}
