//
//  GridMainScreenView.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 06/08/25.
//

import SwiftUI

struct GridMainScreenView: View {
    let missions: [Mission]
    let columns: [GridItem]
    let astronauts: [String: Astronaut]
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack {
                            Text(mission.displayedName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    GridMainScreenView(
        missions: Bundle.main.decode("missions.json"), columns: [GridItem(.adaptive(minimum: 150))], astronauts: Bundle.main.decode("astronauts.json")
    )
}
