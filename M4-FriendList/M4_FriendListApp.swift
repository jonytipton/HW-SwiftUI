//
//  M4_FriendListApp.swift
//  M4-FriendList
//
//  Created by Jonathan Tipton on 8/24/23.
//

import SwiftUI

@main
struct M4_FriendListApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
