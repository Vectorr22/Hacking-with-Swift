//
//  Mission.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 26/07/25.
//

import Foundation

struct Mission: Codable, Identifiable {
    var displayedName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}
