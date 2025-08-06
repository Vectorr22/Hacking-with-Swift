//
//  ListMainScreenView.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 06/08/25.
//

import SwiftUI

struct ListMainScreenView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts), 
                    label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            Spacer()
                            VStack {
                                Text(
                                    mission.displayedName
                                )
                                .font(.headline)
                                .foregroundStyle(.white)
                                
                                Text(
                                    mission.formattedLaunchDate
                                )
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                            }
                            Spacer()
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                    
                )
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    ListMainScreenView(
        missions: Bundle.main.decode("missions.json"), astronauts: Bundle.main.decode("astronauts.json")
    )
    
}
