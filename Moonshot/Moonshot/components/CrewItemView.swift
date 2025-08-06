//
//  HorizontalCrewView.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 06/08/25.
//

import SwiftUI

struct CrewItemView: View {
    let crewMember: CrewMember
    var body: some View {
        NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
        } label : {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.capsule)
                    .overlay(
                     Capsule()
                        .strokeBorder(.white, lineWidth: 1)
                    )
                
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                    
                    Text(crewMember.role)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CrewItemView(crewMember: CrewMember(role: "Lider", astronaut: Astronaut(id: "Example id", name: "Victor", description: "This is an astronaut")))
}
