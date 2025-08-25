//
//  Habit.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 18/08/25.
//

import Foundation

struct Habit: Hashable, Identifiable, Codable {
    var id = UUID()
    let name: String
    let category: Category
    let description: String?
    let timeDurationMillis: Int
    var timesCompleted: Int = 0 
}
