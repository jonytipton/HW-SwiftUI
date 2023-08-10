//
//  ContentView.swift
//  P12-CoreData
//
//  Created by Jonathan Tipton on 7/21/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var isFilterFieldShowing = false
    @State private var filterKeyword = ""
    @State private var typedKeyword = ""
    @State private var selectedPredicateType: PredicateType = .BEGINSWITH
    
    @State private var reverseSort = false
//    @State private var lastNameFilter = "A"
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    var body: some View {
        NavigationView {
//            VStack {
//                List {
//                    ForEach(countries, id: \.self) { country in
//                        Section(country.wrappedFullName) {
//                            ForEach(country.candyArray, id: \.self) { candy in
//                                Text(candy.wrappedName)
//                            }
//                        }
//                    }
//                }
//
//                Button("Add Examples") {
//                    let candy1 = Candy(context: moc)
//                    candy1.name = "Mars"
//                    candy1.origin = Country(context: moc)
//                    candy1.origin?.shortName = "UK"
//                    candy1.origin?.fullName = "United Kingdom"
//
//                    let candy2 = Candy(context: moc)
//                    candy2.name = "KitKat"
//                    candy2.origin = Country(context: moc)
//                    candy2.origin?.shortName = "UK"
//                    candy2.origin?.fullName = "United Kingdom"
//
//                    let candy3 = Candy(context: moc)
//                    candy3.name = "Twix"
//                    candy3.origin = Country(context: moc)
//                    candy3.origin?.shortName = "UK"
//                    candy3.origin?.fullName = "United Kingdom"
//
//                    let candy4 = Candy(context: moc)
//                    candy4.name = "Toblerone"
//                    candy4.origin = Country(context: moc)
//                    candy4.origin?.shortName = "CH"
//                    candy4.origin?.fullName = "Switzerland"
//
//                    try? moc.save()
//                }
//            }
            
            VStack {
                GenericFilteredList(filterKey: "fullName", filterValue: filterKeyword, predicateType: selectedPredicateType, sortDescriptors: [SortDescriptor(\Country.fullName, order: reverseSort ? SortOrder.reverse : SortOrder.forward)]) { (country: Country) in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    reverseSort.toggle()
                } label: {
                    Image(systemName: reverseSort ? "arrow.up.circle" : "arrow.down.circle")
                }
                
                Button {
                    isFilterFieldShowing = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            .alert("Filter by", isPresented: $isFilterFieldShowing) {
                //Does not work in alert view
//                Picker(selection: $selectedPredicateType) {
//                    ForEach(PredicateType.allCases, id: \.self) {
//                        Text($0.rawValue)
//                    }
//                } label: {
//                    Text("Predicate Type")
//                }
                //.pickerStyle(.inline)
                TextField("Filter Text", text: $typedKeyword).textInputAutocapitalization(.never)
                Button {
                    filterKeyword = typedKeyword
                    selectedPredicateType = .CONTAINS
                    print("Keyword is: \(filterKeyword)")
                    print("Predicate Type is: \(selectedPredicateType)")
                } label: {
                    Text("Contains")
                }
                Button {
                    selectedPredicateType = .BEGINSWITH
                    filterKeyword = typedKeyword
                    print("Keyword is: \(filterKeyword)")
                    print("Predicate Type is: \(selectedPredicateType)")
                } label: {
                    Text("Begins With")
                }
                Button("Cancel", role: .cancel) {
                    typedKeyword = ""
                }
            }
        }
        
//        VStack {
//            //list of matching singers
//            GenericFilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//
//            Button("Add Examples") {
//                let taylor = Singer(context: moc)
//                taylor.firstName = "Taylor"
//                taylor.lastName = "Swift"
//
//                let ed = Singer(context: moc)
//                ed.firstName = "Ed"
//                ed.lastName = "Sheeran"
//
//                let adele = Singer(context: moc)
//                adele.firstName = "Adele"
//                adele.lastName = "Adkins"
//
//                try? moc.save()
//            }
//
//            Button("Show A") {
//                lastNameFilter = "A"
//            }
//
//            Button("Show S") {
//                lastNameFilter = "S"
//            }
//        }
//
//
//        VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: moc)
//                ship4.name = "executor"
//                ship4.universe = "Star Wars"
//
//                try? moc.save()
//            }
//
//
//        }
//        .padding()
//
//
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
