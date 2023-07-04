//
//  ExpenseItem.swift
//  P-iExpense
//
//  Created by Jonathan Tipton on 7/4/23.
//

import Foundation

/*
 Identifiable - This type can be identified uniquely
 No longer need to provide id in ForEach when using Identifiable protocol
 */
struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
