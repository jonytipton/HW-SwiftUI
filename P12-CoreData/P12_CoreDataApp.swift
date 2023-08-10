//
//  P12_CoreDataApp.swift
//  P12-CoreData
//
//  Created by Jonathan Tipton on 7/21/23.
//

import CoreData
import SwiftUI

@main
struct P12_CoreDataApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //viewContext allows us to work with data from memory as opposed to storage (where Core Data loads/saves)
        }
    }
}
