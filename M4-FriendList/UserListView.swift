//
//  UserListView.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import SwiftUI

struct UserListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    //@State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(cachedUsers, id: \.id) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text(user.wrappedCompany)
                            }
                            
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(user.friendsArray.count) friends")
                                Text(user.isActive ? "Online" : "Offline")
                                    .padding(5)
                                    .background(user.isActive ? .green : .red, in: RoundedRectangle(cornerRadius: 8))
                            }
                            
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                //TODO: \.self is reused between rows, would need to make a new property to include tag String and a new UUID to be Identifiable/Hashable
//                                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
//                                    ForEach(user.tags, id: \.self) { tag in
//                                        Text(tag)
//                                            .padding(5)
//                                            .background(.teal, in: RoundedRectangle(cornerRadius: 8))
//                                    }
//                                }
//                            }
                    }
                        .padding([.top])

                }
            }
            .task {
                await loadUserData()
            }
            .navigationTitle("FriendList")
        }
        
    }
    
    func loadUserData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Invalid URL: https://www.hackingwithswift.com/samples/friendface.json")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                let loadedUsers = decodedResponse
                
                await MainActor.run {
                    for user in loadedUsers {
                        let newUser = CachedUser(context: moc)
                        newUser.id = user.id
                        newUser.about = user.about
                        newUser.address = user.address
                        newUser.age = Int16(user.age)
                        newUser.company = user.company
                        newUser.email = user.email
                        
                        newUser.isActive = user.isActive
                        newUser.name = user.name
                        newUser.registered = user.registered
                        newUser.tags = user.tags.joined(separator: ",")
                        
                        for friend in user.friends {
                            let newFriend = CachedFriend(context: moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newUser.addToFriends(newFriend)
                        }
                    }
                    
                    try? moc.save()
                }
                
            } else {
                print("error decoding JSON, displaying cached users")
            }
        } catch {
            print("Invalid data")
        }
                
    }
}
