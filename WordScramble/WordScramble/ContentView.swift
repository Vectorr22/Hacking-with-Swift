//
//  ContentView.swift
//  WordScramble
//
//  Created by Victor Manuel Tijerina Garnica on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var score = 0
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                    
                }
                //if score == 0 {""} else {"Your score is: \(score)"}
                Text(score == 0 ? "Start playing to track yoour score!" : "Your score is: \(score)")
                    .font(.headline)
            }
            .toolbar(content: {
                Button("Reset") {
                    startGame()
                }
            })
            .navigationTitle(rootWord)
            
        }
        .onAppear(perform: startGame)
        .onSubmit(addNewWord)
        .alert(errorTitle, isPresented: $showingError) {} message: {
            Text(errorMessage)
        }
        
        
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return wordError(title: "Empty value", message: "Please enter a word!") }
        
        guard answer != rootWord else {
            return wordError(title: "Cheater!", message: "You can't use the root word!")
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += 1
        }
        newWord = ""
        
    }
    
     private func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                
                print(allWords.randomElement() ?? "no word")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                usedWords.removeAll()
                
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
