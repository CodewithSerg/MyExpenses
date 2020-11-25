//
//  ExpenseItem.swift
//  MyExpenses
//
//  Created by Sergey Antoniuk on 11/25/20.
//

import Foundation

// Одна единичная затрата

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
