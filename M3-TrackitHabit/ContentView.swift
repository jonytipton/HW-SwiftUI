//
//  ContentView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    
    @State private var totalHabits: Int = 0
    @State private var completedHabits: Int = 0
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            VStack {
                RingView(totalHabits: $totalHabits, completedHabits: $completedHabits)
                    .padding()
                List {
                    Section("My Habits") {
                        ForEach(habits.habits) { habit in
                            NavigationLink {
                                DetailHabitView(habit: habit, habits: habits)
                            } label: {
                                HStack {
                                    Text(habit.name)
                                    Spacer()
                                    Text(habit.completedToday ? "Completed" : "")
                                        .opacity(0.5)
                                }
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    complete(habit: habit)
                                } label: {
                                    Text("Complete")
                                }
                                .tint(.cyan)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    .listRowBackground(LinearGradient(colors: [.cyan, .mint], startPoint: .leading, endPoint: .trailing).opacity(0.75))
                }
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .padding(.top)
            .navigationTitle("TrackitHabit")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(.mint)
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habits: habits)
            }
            .onAppear {
                totalHabits = habits.habits.count
                
                var count = 0
                for habit in habits.habits {
                    if habit.lastCompleted == Date.now.formatted(date: .abbreviated, time: .omitted) {
                        count += 1
                    }
                }
                completedHabits = count
            }
            .onChange(of: habits.habits) { _ in
                totalHabits = habits.habits.count
                
                var count = 0
                for habit in habits.habits {
                    if habit.lastCompleted == Date.now.formatted(date: .abbreviated, time: .omitted) {
                        count += 1
                    }
                }
                completedHabits = count
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.habits.remove(atOffsets: offsets)
    }
    
    func complete(habit: Habit) {
        if let index = habits.habits.firstIndex(of: habit) {
            let habit = habits.habits[index]
            if !habit.completedToday {
                habits.habits[index].incrementHabit()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
