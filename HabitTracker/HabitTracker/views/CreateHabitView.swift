//
//  CreateHabitView.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 20/08/25.
//

import SwiftUI

struct CreateHabitView: View {
    @Environment(\.dismiss) var dismiss
    @State private var habitTitle: String = ""
    @State private var description: String = ""
    @State private var selectedCategory: Category?
    @State private var minutes = 10
    var categories: Categories
    var habits: Habits
    
    
    
    init(categories: Categories, habits: Habits) {
        self.categories = categories
        self.habits = habits
        _selectedCategory = State(initialValue: categories.categories.first)
    }
    
    var body: some View {
        
        VStack(spacing: 8){
            TextField("Title", text: $habitTitle)
                .frame(maxHeight: 50)
                .padding()
                .background(.lightGreenMint)
                .clipShape(.buttonBorder)
                .padding(.bottom)
            
                
            
            TextField("Description (optional)", text: $description)
                .frame(maxHeight: 150)
                .padding()
                .background(.lightGreenMint)
                .clipShape(.buttonBorder)
                .padding(.bottom)
            
            
            HStack {
                Text("Category ")
                Spacer()
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories.categories) { category in
                        Text(category.name).tag(Optional(category))
                    }
                }
            }.frame(maxWidth: .infinity)
            
            
            
            
            
            VStack(alignment: .leading) {
                Text("Duration")
                    .padding(.bottom)
                
                Stepper("\(minutes) min", value: $minutes, in: 1...120, step: 5)
            }.padding(.top)
            
            
            Spacer()
            
            Button {
                let millis = minutes * 60 * 1000
                let newHabit = Habit(name: habitTitle, category: selectedCategory!, description: description, timeDurationMillis: millis)
                habits.listOfHabits.append(newHabit)
                dismiss()
            } label: {
                Text("Save")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, maxHeight: 50)
                .background(.brightGreen)
                .clipShape(.buttonBorder)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            .navigationTitle("Create habit")
    }
}

#Preview {
    CreateHabitView(categories: Categories(), habits: Habits())
}
