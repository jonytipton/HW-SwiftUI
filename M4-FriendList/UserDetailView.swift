//
//  UserDetailView.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let rows = [
        GridItem(.flexible())]
    
    var body: some View {
        
        VStack(spacing: 0) {
            List {
                Section("About") {
                    Text(user.about)
                }
                Section("Age") {
                    Text("\(user.age)")
                }
                Section("Email") {
                    Text(user.email)
                }
                Section("Company") {
                    Text(user.company)
                }
                Section("Address") {
                    Text("\(user.address)")
                }
                Section("Tags") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 10) {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(5)
                                    .background(.teal, in: RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    //.scrollClipDisabled(true) //iOS 17 api
                }

                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                
                Section("Account") {
                    Text(user.isActive ? "Online" : "Offline")
                        .padding(5)
                        .background(user.isActive ? .green : .red, in: RoundedRectangle(cornerRadius: 8))
                    Text(user.registered.description)
                }
                
            }
        }
        .navigationTitle(user.name)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let testUser = User()
        UserDetailView(user: testUser)
    }
}
