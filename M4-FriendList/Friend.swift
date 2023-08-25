//
//  Friend.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
