//
//  LoadRemoteImage.swift
//  P10-CupcakeCorner
//
//  Created by Jonathan Tipton on 7/16/23.
//

import SwiftUI

struct LoadRemoteImage: View {
    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadRemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadRemoteImage()
    }
}
