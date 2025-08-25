//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 19/08/25.
//

import SwiftUI

struct HabitDetailView: View {
    @Binding var habit: Habit
    let habits: Habits
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(habit.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            
            
            Text(habit.description ?? "No description")
                .font(.title2)
                .padding(.bottom)
            
            
            
            VStack(alignment: .leading,spacing: 12){
                Text("Completed")
                
                Text(String(habit.timesCompleted))
                    .font(.title)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(.lightGreen, lineWidth: 1))
            
            
            Spacer()
            
            Button{
                if let index = habits.listOfHabits.firstIndex(where: {$0.id == habit.id}) {
                    habits.listOfHabits[index].timesCompleted += 1
                }
            } label: {
                Text("Mark as done")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }.frame(maxWidth: .infinity, maxHeight: 50)
                .background(.brightGreen)
                .clipShape(.buttonBorder)
                
            
            
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading).padding()
            .navigationTitle("Habit tracker")
    }
}

#Preview {
    let category = Category(name: "Morning", image: "read")
    
    @State var habit = Habit(name: "Meditate", category: category, description: "Start your day with a 10-minute meditation and set your mind and set your time to a positive true.", timeDurationMillis: 5000, timesCompleted: 0)
    
    return HabitDetailView(habit: $habit, habits: Habits())
}
