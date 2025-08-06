//
//  ContentView.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 25/07/25.
//

import SwiftUI


struct ContentView: View {
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showGrid: Bool = true
    

    var body: some View {
        NavigationStack{
            ScrollView {
                if showGrid{
                    GridMainScreenView(missions: missions, columns: columns, astronauts: astronauts)
                }
                else {
                    ListMainScreenView(missions: missions, astronauts: astronauts)
                }
                
                
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                let text = if showGrid {"Grid"} else {"List"}
                Toggle(text, isOn: $showGrid)
                    .padding()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
