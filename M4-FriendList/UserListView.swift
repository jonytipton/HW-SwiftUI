//
//  UserListView.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import SwiftUI

struct UserListView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                        Text(user.name)
                                .font(.headline)
                            ScrollView(.horizontal, showsIndicators: false) {
                                //TODO: \.self is reused between rows, would need to make a new property to include tag String and a new UUID to be Identifiable/Hashable
                                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                                    ForEach(user.tags, id: \.self) { tag in
                                        Text(tag)
                                            .padding(5)
                                            .background(.teal, in: RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                            }
                    }
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
                users = decodedResponse
            } else {
                print("error decoding JSON")
            }
        } catch {
            print("Invalid data")
        }
                
    }
}
