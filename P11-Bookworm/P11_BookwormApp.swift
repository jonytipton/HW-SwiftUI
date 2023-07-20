//
//  P11_BookwormApp.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/18/23.
//

import SwiftUI

@main
struct P11_BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //viewContext allows us to work with data from memory as opposed to storage (where Core Data loads/saves)
        }
    }
}
