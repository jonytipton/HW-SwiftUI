//
//  AddHabitView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/15/23.
//

import SwiftUI

struct AddHabitView: View {
    @State private var name = ""
    @State private var description = ""
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habits: Habits
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Description") {
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add New Habit")
            .toolbar {
                Button("Save") {
                    let habit = Habit(name: name, description: description)
                    habits.habits.append(habit)
                    dismiss()
                }
            }
            .tint(.mint)
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
