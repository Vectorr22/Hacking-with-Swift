//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Victor Manuel Tijerina Garnica on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                }
                
                Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        
                        Toggle("Add extra frozing", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
                
                
            }.navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
