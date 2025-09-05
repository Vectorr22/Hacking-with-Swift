//
//  HabitOverview.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 19/08/25.
//

import SwiftUI

struct HabitOverview: View {
    let habit: Habit
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                Text(habit.category.name)
                    .foregroundStyle(.lightGreen)
                
                Text(habit.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(formatDuration(habit.timeDurationMillis))
                    .foregroundStyle(.lightGreen)
                
            }
            
            Spacer()
            
            Image(habit.category.image)
                .resizable()
                .scaledToFit()
                .clipShape(.buttonBorder)
                .frame(width: 150, height: 100)
                
                
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
    
    
}

private func formatDuration(_ seconds: Int) -> String {
    let minutes = seconds / 60
    let hours = minutes / 60
    
    if hours > 0 {
        return hours == 1 ? "1 hour" : "\(hours) hours"
    } else if minutes > 0 {
        return minutes == 1 ? "1 minute" : "\(minutes) minutes"
    } else {
        return "\(seconds) seconds"
    }
}

#Preview {
    let category = Category(name: "Morning", image: "read")
    
    let habit = Habit(name: "Meditate", category: category, description: nil, timeDurationMillis: 5000, timesCompleted: 0)
    
    return HabitOverview(habit:habit)
        
}
