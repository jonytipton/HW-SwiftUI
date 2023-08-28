//
//  UserDetailView.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc

    let user: CachedUser
    let rows = [
        GridItem(.flexible())]
    
    //var selectedFriend: CachedUser? = nil
    
    var body: some View {
        
        VStack(spacing: 0) {
            List {
                Section("About") {
                    Text(user.wrappedAbout)
                }
                Section("Age") {
                    Text("\(user.age)")
                }
                Section("Email") {
                    Text(user.wrappedEmail)
                }
                Section("Company") {
                    Text(user.wrappedCompany)
                }
                Section("Address") {
                    Text("\(user.wrappedAddress)")
                }
                Section("Tags") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 10) {
                            ForEach(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                                Text(tag)
                                    .padding(5)
                                    .background(.teal, in: RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    //.scrollClipDisabled(true) //iOS 17 api
                }

                
                Section("Friends") {
                    ForEach(user.friendsArray) { friend in
                            Text(friend.wrappedName)
                    }
                }
                
                Section("Account") {
                    Text(user.isActive ? "Online" : "Offline")
                        .padding(5)
                        .background(user.isActive ? .green : .red, in: RoundedRectangle(cornerRadius: 8))
                    Text(user.wrappedRegistered.description)
                }
                
            }
        }
        .navigationTitle(user.wrappedName)
    }
    
//    func lookupUserByID(_ id: UUID) {
//        let request = CachedUser.fetchRequest()
//        do {
//            let users = try? moc.fetch(request)
//            selectedFriend = users?.first(where: { $0.id == id })
//        }
//    }
}

//struct UserDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let testUser = User()
//        UserDetailView(user: testUser)
//    }
//}
