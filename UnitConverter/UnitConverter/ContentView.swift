//
//  ContentView.swift
//  UnitConverter
//
//  Created by Victor Manuel Tijerina Garnica on 01/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input: Double = 0
    @State private var currentSelectedConversion = "Temperature"
    @State private var currentSelectedInputType = "Celcius"
    @State private var currentSelectedOutputType = "Fahrenheit"
    @FocusState private var isFocused: Bool
    
    let lengthFactors: [String: Double] = [
        "Meters": 1,
        "Kilometers": 1000,
        "Feet": 0.3048,
        "Yards": 0.9144,
        "Miles": 1609.34
    ]
    
    let timeFactors: [String: Double] = [
        "Seconds": 1,
        "Minutes": 60,
        "Hours": 3600,
        "Days": 86400
    ]
    
    let volumeFactors: [String: Double] = [
        "Milliliters": 1,
        "Liters": 1000,
        "Cups": 240,
        "Pints": 473.176,
        "Gallons": 3785.41
    ]
    
    
    
    private func convertValues(_ conversion: String, inputType: String, outputType: String, from: Double) -> Double{
        print("variables are: \(conversion), \(inputType), \(outputType), \(from)")
        if conversion == "Temperature"{
            var celsiusValue: Double
            switch inputType{
            case "Celsius":
                celsiusValue = from
            case "Fahrenheit":
                celsiusValue = (from - 32) * 5/9
            case "Kelvin":
                celsiusValue = from - 273.15
            default:
                return 0
            }
            
            switch outputType {
            case "Celsius":
                return celsiusValue
            case "Fahrenheit":
                return (celsiusValue * 9/5) + 32
            case "Kelvin":
                return celsiusValue + 273.15
            default:
                return 0
            }
        }
        else{
            switch conversion{
            case "Length":
                guard let fromFactor = lengthFactors[inputType],let toFactor = lengthFactors[outputType] else { return 0 }
                let baseValue = from * fromFactor
                return baseValue / toFactor
                
            case "Time":
                guard let fromFactor = timeFactors[inputType], let toFactor = lengthFactors[outputType] else {return 0}
                let base = from * fromFactor
                return base / toFactor
                
                
                
            case "Volume":
                guard let fromFactor = volumeFactors[inputType],let toFactor = volumeFactors[outputType] else { return 0 }
                let baseValue = from * fromFactor
                return baseValue / toFactor
                
            default:
                return 0.0
            }
        }
    }
    
    
    private var conversions = ["Temperature","Length","Time","Volume"]
    private let conversionUnits = [
        "Temperature": ["Celsius", "Fahrenheit", "Kelvin"],
        "Length": ["Meters","Kilometers","Feet","Yards","Miles"],
        "Time": ["Seconds","Minutes","Hours","Days"],
        "Volume": ["Milimiters","Liters","Cups","Pints","Gallons"]
    ]
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var output: Double {
        return convertValues(currentSelectedConversion, inputType: currentSelectedInputType, outputType: currentSelectedOutputType, from: input)
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select your conversion", selection: $currentSelectedConversion){
                        ForEach(conversions, id: \.self){ conversion in
                            Text(conversion)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                Section{
                    HStack{
                        Picker("From", selection: $currentSelectedInputType){
                            switch(currentSelectedConversion){
                            case "Temperature":
                                ForEach(conversionUnits["Temperature"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Length":
                                ForEach(conversionUnits["Length"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Time":
                                ForEach(conversionUnits["Time"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Volume":
                                ForEach(conversionUnits["Volume"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            default:
                                Text("None")
                            }
                            
                        }
                        Picker("To", selection: $currentSelectedOutputType){
                            switch(currentSelectedConversion){
                            case "Temperature":
                                ForEach(conversionUnits["Temperature"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Length":
                                ForEach(conversionUnits["Length"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Time":
                                ForEach(conversionUnits["Time"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            case "Volume":
                                ForEach(conversionUnits["Volume"]!, id: \.self){ option in
                                    Text(option)
                                }
                                
                            default:
                                Text("None")
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Section("Input"){
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                }
                
                Section("Output"){
                    Text(
                        output,
                        format: .number
                    )
                }
            }
            .navigationTitle("Unit converter")
            .toolbar(content: {
                if isFocused{
                    Button("Done"){
                        isFocused = false
                    }
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
