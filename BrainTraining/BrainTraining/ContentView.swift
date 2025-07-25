//
//  ContentView.swift
//  BrainTraining
//
//  Created by Victor Manuel Tijerina Garnica on 19/04/25.
//

import SwiftUI

struct ContentView: View {
    
    let options = ["✊🏻","✋🏻","✌🏻"]
    @State var machineAnswer = Int.random(in: 0...2)
    @State private var hasUserWon: Bool = false
    @State private var hasUserLoose = false
    @State private var showScorePopup = false
    @State private var hasGameEnded = false
    @State private var alertTitle = ""
    @State private var alertSubtitle = ""
    @State private var wins = 0
    @State private var looses = 0
    @State private var currentRound = 1
    var body: some View {
        ZStack{
            //Gradient background
            LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                Text("Rock, paper, scissors!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Can you beat me? Choose!")
                    .font(.system(size: 25, weight: .regular))
                
                VStack(spacing: 15){
                    ForEach(0..<3){ number in
                        Button(options[number]){
                            checkAnswer(optionSelected: number)
                        }
                        .font(.system(size: 125))
                        .shadow(radius: 30)
                        
                        
                        
                    }
                    
                }
                
                HStack{
                    Text("Wins: \(wins)")
                    
                    Text("Losses: \(looses)")
                }
                .font(.largeTitle)
                .fontWeight(.semibold)
                    
                
                
            }
            
        }
        .alert(alertTitle, isPresented: $showScorePopup, actions: {
            Button("Ok"){
                
            }
        }, message: {Text(alertSubtitle)})
        .alert("Game ended!", isPresented: $hasGameEnded, actions: {
            Button("Replay"){
                restartGame()
            }
            Button("Exit",role: .destructive){
                
            }
        }, message: {
            Text("""
Game ended! Your score was
Wins: \(wins) Looses: \(looses)
""")
    
            
        })
    }
    
    private func checkAnswer(optionSelected: Int){
        switch optionSelected{
        case 0:
            if machineAnswer == 1{
                hasUserLoose = true
                
            }
            else if machineAnswer == 2 {
                hasUserWon = true
            }
            else{
                
            }
            
        case 1:
            
            if machineAnswer == 0{
                hasUserWon = true
            }
            else if machineAnswer == 2 {
                hasUserLoose = true
            }
            else{
                
            }
            
        case 2:
            
            if machineAnswer == 0{
                hasUserLoose = true
            }
            else if machineAnswer == 1 {
                hasUserWon = true
            }
            else{
                
            }
            
            
        default: print("error")
            
        }
        configurePopup()
        showScorePopup = true
        
        if currentRound == 3{
            hasGameEnded = true
        }
        else{
            currentRound+=1
            hasUserWon = false
            hasUserLoose = false
            machineAnswer = Int.random(in: 0...2)
        }
        
    }
    
    private func configurePopup(){
        if hasUserWon{
            alertTitle = "You won!"
            wins+=1
        }
        else if hasUserLoose{
            alertTitle = "You loose!"
            looses+=1
        }
        else{
            alertTitle = "Draw!"
        }
        alertSubtitle = "I choosed \(options[machineAnswer])"
    }
    
    private func restartGame(){
        hasGameEnded = false
        machineAnswer = Int.random(in: 0...2)
        wins = 0
        looses = 0
        currentRound = 1
    }
}

#Preview {
    ContentView()
}
