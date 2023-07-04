//
//  ContentView.swift
//  P-iExpense
//
//  Created by Jonathan Tipton on 7/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses() //@StateObject when creating, @ObservedObject when referencing
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if (item.type == "Personal") {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    //Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount > 100 ? .red : item.amount > 10 ? .orange : .green)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if (item.type == "Business") {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    //Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(item.amount > 100 ? .red : item.amount > 10 ? .orange : .green)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
