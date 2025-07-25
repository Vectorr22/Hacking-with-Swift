//
//  AddView.swift
//  iExpense
//
//  Created by Victor Manuel Tijerina Garnica on 21/07/25.
//

import SwiftUI

struct AddExpense: View {
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    let currencies = ["USD","MXN","EUR"]
    @State private var currency = "USD"
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)       
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new Expense")
            .toolbar {
                Button("Save") {
                    let color: String
                    let brutalAmount: Double
                    guard let realAmount = Double(amount) else { return
                    }
                    switch currency {
                    case "MXN":
                        brutalAmount = realAmount / 18.64
                    case "EUR":
                        brutalAmount = realAmount / 1.17
                    default:
                        brutalAmount = realAmount
                    }
                    
                    switch brutalAmount {
                    case 1.0..<10.0:
                        color = "Green"
                            
                    case 10.0..<100.0:
                        color = "Yellow"
                        
                    default:
                        color = "Red"
                    }
                    
                    
                    
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency, color: color)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpense(expenses: Expenses())
}
