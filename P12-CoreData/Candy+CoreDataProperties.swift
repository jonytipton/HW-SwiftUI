//
//  Candy+CoreDataProperties.swift
//  P12-CoreData
//
//  Created by Jonathan Tipton on 8/6/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown"
    }
}

extension Candy : Identifiable {

}
