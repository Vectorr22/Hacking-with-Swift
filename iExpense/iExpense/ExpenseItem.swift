//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Victor Manuel Tijerina Garnica on 21/07/25.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: String
    let currency: String
    let color: String
}
