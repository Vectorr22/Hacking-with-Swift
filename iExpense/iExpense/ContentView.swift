//
//  ContentView.swift
//  iExpense
//
//  Created by Victor Manuel Tijerina Garnica on 17/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter({
                        $0.type == "Personal"
                    })) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(colorFor(item.color))
                                
                                
                            
                            Text(Double(item.amount) ?? 0.0, format: .currency(code: item.currency))
                                
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeExpense(at: indexSet, in: "Personal")
                    })
                }
            }
            
            List {
                Section("Business") {
                    ForEach(expenses.items.filter({ item in
                        item.type == "Business"
                    })) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            Image(systemName: "arrow.up")
                                .foregroundColor(colorFor(item.color))
                                
                                
                            
                            Text(Double(item.amount) ?? 0.0, format: .currency(code: item.currency))
                                
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeExpense(at: indexSet, in: "Business")
                    })
                }
            }
            
            .navigationTitle("iExpenses")
            .toolbar(content: {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            )
        }
        .sheet(isPresented: $showingAddExpense, content: {
            AddExpense(expenses: expenses)
        })
    }
    
    
    private func removeExpense(at offsets: IndexSet, in type: String) {
        let filteredExpenses = expenses.items.enumerated().filter({
            $0.element.type == type
            }
        )
        
        let actualIndices = offsets.map {
            filteredExpenses[$0].offset
        }
        expenses.items.remove(atOffsets: IndexSet(actualIndices))
    }
    private func colorFor(_ value: String) -> Color {
        switch value {
        case "Green": return .green
        case "Yellow": return .yellow
        case "Red": return .red
        default: return .gray
        }
    }
}

#Preview {
    ContentView()
}


