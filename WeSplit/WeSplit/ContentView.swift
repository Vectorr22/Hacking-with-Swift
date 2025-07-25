//
//  ContentView.swift
//  WeSplit
//
//  Created by Victor Manuel Tijerina Garnica on 30/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    let tipPercentages = [0,10,15,20,25]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        let amountPerPerson = (checkAmount + tipValue) / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheck: Double{
        let tipValue = checkAmount / 100 * (Double(tipPercentage))
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField(
                        "Amount", value: $checkAmount, format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($isAmountFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){ number in
                            Text("\(number) people")
                            
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section("Tip percentage:"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){ number in
                            Text("\(number)%")
                                .foregroundStyle(tipPercentage == 0 ? .red : .blue)
                            
                            
                        }
//                        ForEach(tipPercentages, id: \.self){ percentage in
//                            Text(percentage, format: .percent)
//                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total per person"){
                    Text(
                        totalPerPerson,
                        format:
                            .currency(code:Locale.current.currency?.identifier ?? "USD")
                    )
                }
                
                Section("Total check: "){
                    Text(
                        totalCheck,
                        format:
                                .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }
            }
            .navigationTitle("WeSplit")
            .toolbar(content: {
                if isAmountFocused {
                    Button("Done"){
                        isAmountFocused = false
                    }
                }
            })
        }
        
    }
}

#Preview {
    ContentView()
}
