//
//  ContentView.swift
//  HabitTracker
//
//  Created by Victor Manuel Tijerina Garnica on 18/08/25.
//

import SwiftUI


struct ContentView: View {
    @State var categories: Categories = Categories()
    @State var habits: Habits = Habits()
    
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottomTrailing){
                ScrollView{
                    LazyVStack(content: {
                        ForEach($habits.listOfHabits) { $habit in
                            NavigationLink(
                                destination: HabitDetailView(habit: $habit, habits: habits)
                            ){
                                HabitOverview(habit: habit)
                            }.buttonStyle(.plain)
                        }
                    }
                    )
                }
                .toolbar{
                    Button {
                        path.append("CreateCategoryView")
                    } label: {
                        Text("New category")
                    }
                }
                
                Button(action: {
                    path.append("CreateHabitView")
                    
                }, label: {
                    Image(systemName: "plus")
                        .font(.headline.bold())
                        .padding(20)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                ).padding()
                
            }
            .padding()
            .navigationTitle("Habits")
            .navigationDestination(for: String.self) { value in
                if value == "CreateHabitView" {
                    CreateHabitView(categories: categories, habits: habits)
                }
                else if value == "CreateCategoryView" {
                    CreateCategoryView(categories: categories)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
