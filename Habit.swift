//
//  Habit.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/15/23.
//

import Foundation

struct Habit: Codable, Equatable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int = 0
    var lastCompleted: String = ""
    var completedToday: Bool {
        return lastCompleted == Date.now.formatted(date: .abbreviated, time: .omitted)
    }
    
    mutating func incrementHabit() {
        completionCount += 1
        lastCompleted = Date.now.formatted(date: .abbreviated, time: .omitted)
    }
    
    mutating func decrementHabit() {
        completionCount -= 1
    }
}
