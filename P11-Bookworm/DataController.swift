//
//  DataController.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/18/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm") //refers to Bookworm.xcdatamodel
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
