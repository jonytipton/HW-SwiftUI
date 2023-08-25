//
//  User.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    //For UserDetailView preview
    init() {
        id = UUID()
        isActive = true
        name = "John Appleseed"
        age = 25
        company = "Apple"
        email = "john_appleseed@apple.com"
        address = "1 Infinite Loop"
        about = "Just another SWE in CA."
        registered = Date.now
        tags = ["tag1", "tag2", "tag3"]
        friends = [Friend(id: UUID(), name: "Ashley Watson"), Friend(id: UUID(), name: "Billy Stenson")]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try UUID(uuidString: container.decode(String.self, forKey: .id))!
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(Date.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
    }
}
