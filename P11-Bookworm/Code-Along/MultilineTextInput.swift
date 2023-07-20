//
//  MultilineTextInput.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/18/23.
//

import SwiftUI

struct MultilineTextInput: View {
    //Backed by UserDefaults
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct MultilineTextInput_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextInput()
    }
}
