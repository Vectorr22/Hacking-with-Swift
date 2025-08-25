//
//  Categories.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 20/08/25.
//

import Foundation



@Observable
class Categories {
    
    init() {
        if let savedCategories = UserDefaults.standard.data(forKey: "Categories") {
            if let decodedCategories = try? JSONDecoder().decode([Category].self, from: savedCategories) {
                categories = decodedCategories
                return
            }
        }
        categories = []
    }
    
    var categories = [Category](){
        didSet {
            if let codedCategories = try? JSONEncoder().encode(categories) {
                UserDefaults.standard.setValue(codedCategories, forKey: "Categories")
            }
            
        }
    }
}
