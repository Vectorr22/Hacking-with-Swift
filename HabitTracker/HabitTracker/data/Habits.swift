//
//  Habits.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 20/08/25.
//

import Foundation


@Observable
class Habits {
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems){
                listOfHabits = decodedItems
                return
            }
        }
        
        listOfHabits = []
    }
    
    var listOfHabits: [Habit]{
        didSet{
            if let encode = try? JSONEncoder().encode(listOfHabits) {
                UserDefaults.standard.setValue(encode, forKey: "Habits")
            }
        }
    }
}
