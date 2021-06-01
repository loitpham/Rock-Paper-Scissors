//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Loi Pham on 5/31/21.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    var imageName: String {
        switch text {
            case "Rock":
                return "hexagon.fill"
            case "Paper":
                return "doc.text"
            default:
                return "scissors"
        }
    }
    var body: some View {
        Image(systemName: imageName)
            .font(.largeTitle)
            .foregroundColor(.green)
            .padding()
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
            .shadow(color: .black, radius: 1)
    }
}

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var choice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var comment = ""
//    @State private var showComment = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("App's move")
                    .font(.title)
                Text("\(moves[choice])")
                    .font(.title)
                    .foregroundColor(.purple)           
                
                Spacer()
                Text("Player should \(shouldWin ? "win" : "lose").")
                    .font(.title)
                Spacer()
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(action: {
                            checkAnswer(move)
                        }) {
                            ButtonView(text: move)
                        }
                    }
                }
                Spacer()
                Text(comment)
                    .font(.body)
                Text("Score")
                    .font(.title)
                Text("\(score)")
                    .font(.title)
            }
        }
    }
    
    func checkAnswer(_ move: String) {
        var correctAnswer = ""
        switch moves[choice] {
        case "Rock":
            correctAnswer = "Paper"
        case "Paper":
            correctAnswer = "Scissors"
        default:
            correctAnswer = "Rock"
        }
        if (shouldWin && move == correctAnswer) || (!shouldWin && move != correctAnswer) {
            score += 1
            comment = "Last round: ✅"
            reset()
        } else {
            comment = "Last round: ❌"
            reset()
        }
    }
    
    func reset() {
        choice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
