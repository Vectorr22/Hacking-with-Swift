//
//  Expenses.swift
//  iExpense
//
//  Created by Victor Manuel Tijerina Garnica on 21/07/25.
//

import Foundation

@Observable
class Expenses {
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
}
