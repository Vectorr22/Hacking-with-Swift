//
//  Category.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 18/08/25.
//

import Foundation

struct Category: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let image: String
}
