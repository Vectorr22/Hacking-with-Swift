//
//  MissionView.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 26/07/25.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    let crew: [CrewMember]

    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                HStack {
                    Spacer()
                    Text(mission.formattedLaunchDate)
                        .foregroundStyle(.white).opacity(0.5)
                        .padding()
                }
                
                Text("Crew")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                CrewItemView(crewMember: crewMember)
                            }
                        }
                    }.scrollIndicators(.hidden)
                    
                    RectangleDivider(background: .lightBackground)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)

                    Text(mission.description)
                    
                    RectangleDivider(background: .lightBackground)
                }
                .padding(.horizontal)
                
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayedName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
