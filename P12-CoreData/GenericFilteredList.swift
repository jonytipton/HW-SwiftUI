//
//  GenericFilteredList.swift
//  P12-CoreData
//
//  Created by Jonathan Tipton on 8/6/23.
//
import CoreData
import SwiftUI

enum PredicateType: String, CaseIterable {
    case BEGINSWITH = "BEGINSWITH"
    case CONTAINS = "CONTAINS"
}

struct GenericFilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    //var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    

    init(filterKey: String, filterValue: String, predicateType: PredicateType, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors,
            predicate: filterValue == "" ? nil : NSPredicate(format: "%K \(predicateType) %@", filterKey, filterValue))
        self.content = content
    }
}

