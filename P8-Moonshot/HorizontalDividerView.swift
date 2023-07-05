//
//  HorizontalDividerView.swift
//  P8-Moonshot
//
//  Created by Jonathan Tipton on 7/6/23.
//

import SwiftUI

struct HorizontalDividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
    }
}

struct HorizontalDividerView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDividerView()
    }
}
