//
//  ContentView.swift
//  BetterRest
//
//  Created by Victor Manuel Tijerina Garnica on 12/07/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    @State private var sleepAMount = 8.0
    @State private var coffeAmount = 1
    @State private var wakeUp = defaultWakeTime
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var cupsOptions =  [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    @State private var selectedCupPickerOption = 1
    
    @State private var showBedTime = false
    @State private var recommendedBedTime = ""
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading , spacing: 10) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading , spacing: 10) {
                    Text("Desired amount of sleep: ")
                        .font(.headline)
                    Stepper(
                        "\(sleepAMount.formatted()) hours",
                        value: $sleepAMount,
                        in: 4...12
                    )
                }
                
                VStack(alignment: .leading , spacing: 10) {
                    Text("Daily coffee intake:")
                        .font(.headline)
                    
                    Picker("Number of cups", selection: $selectedCupPickerOption) {
                        ForEach(cupsOptions, id: \.self) { option in
                            Text(String(option))
                            
                        }
                    }
                    
                    //                    Stepper("^[\(coffeAmount) cup](inflect: true)", value: $coffeAmount, in: 1...20)
                }
                
                if showBedTime {
                    Section("Your recommended bedtime is") {
                        Text(recommendedBedTime)
                            .font(.headline)
                    }
                }
                
                
            }
            .navigationTitle("BetterRest")
            .toolbar{
                if showBedTime {
                    Button("Clear", action: clearValues)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut, value: showBedTime)
                }
                Button("Calculate", action: calculateBedTimeTwo)
            }
            .alert(alertTitle, isPresented: $showingAlert, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            }
            )
        }
        
    }
    
    
    private func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAMount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bed time is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bed time"
        }
        showingAlert = true
        
        
    }
    
    private func calculateBedTimeTwo() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAMount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            recommendedBedTime = "Your ideal bed time is: \(sleepTime.formatted(date: .omitted, time: .shortened))"
            
        } catch {
            recommendedBedTime = "Sorry, there was a problem calculating your bed time"
        }
        
        withAnimation{
            showBedTime.toggle()
        }
        
        
    }
    
    private func clearValues() {
        showBedTime = false
        recommendedBedTime = ""
    }
    
    
    
}

#Preview {
    ContentView()
}
