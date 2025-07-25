//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Victor Manuel Tijerina Garnica on 18/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var contentMessage = ""
    @State private var totalScore = 0
    @State private var hasGameEnded = false
    @State private var questionsAsked = 0
    
    var body: some View {
        ZStack{
//            LinearGradient(colors: [Color.blue, Color.black], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        FlagImage(number: number, countries: countries, buttonPressedAction: {
                            flagTapped(number)
                        })
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(totalScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore){
            Button("Continue", action: askQuestion)
        } message: {Text("""
\(contentMessage)
Your score is \(totalScore)!
""")
        }
        .alert("Game ended", isPresented: $hasGameEnded){
            Button("Restart"){
                questionsAsked = 0
                totalScore = 0
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
            }
            Button("Finish", role: .destructive){
                
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            contentMessage = "Nice one!"
            totalScore+=1
        }
        else{
            scoreTitle = "Wrong"
            contentMessage = "That's the flag of \(countries[number])"
            if totalScore > 0{
                totalScore-=1
            }
        }
        
        showScore = true
    }
    
    func askQuestion(){
        questionsAsked+=1
        if questionsAsked == 8 {
            hasGameEnded = true
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

#Preview {
    ContentView()
}
