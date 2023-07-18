//
//  ValidatingAndDisablingForms.swift
//  P10-CupcakeCorner
//
//  Created by Jonathan Tipton on 7/16/23.
//

import SwiftUI

struct ValidatingAndDisablingForms: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ValidatingAndDisablingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingAndDisablingForms()
    }
}
