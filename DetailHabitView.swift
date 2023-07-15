//
//  DetailHabitView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/15/23.
//

import SwiftUI

struct DetailHabitView: View {
    
    var habit: Habit
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack {
                List {
                    Section("Habit") {
                        Text(habit.name)
                    }
                    Section("Description") {
                        Text(habit.description)
                    }
                    Section("Completion Count") {
                        Text("\(habit.completionCount)")
                    }
                    Section("Last Completed") {
                        Text(habit.lastCompleted)
                    }
                }
                .listStyle(.insetGrouped)
                HStack {
                    Button {
                        deleteHabit()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                            Spacer()
                        }
                        .foregroundStyle(.red)
                    }
                    .padding(.leading)
                    
                    Button {
                        completed()
                    } label: {
                        
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark")
                            Text("Mark Completed")
                            Spacer()
                        }
                        .foregroundStyle(.mint)
                    }
                }
                .padding()
            }
            .navigationTitle("Habit")
    }
    
    func completed() {
        if let index = habits.habits.firstIndex(of: habit) {
            let habit = habits.habits[index]
            if !habit.completedToday {
                habits.habits[index].incrementHabit()
            }
        }
    }
    
    func deleteHabit() {
        if let index = habits.habits.firstIndex(of: habit) {
            habits.habits.remove(at: index)
            dismiss()
        }
    }
}

struct DetailHabitView_Previews: PreviewProvider {
    static var previews: some View {
        DetailHabitView(habit: Habit(name: "TEST NAME", description: "TEST DESCRIPTION"), habits: Habits())
    }
}
