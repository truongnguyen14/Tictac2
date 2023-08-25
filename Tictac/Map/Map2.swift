//
//  ContentView.swift
//  TicTacToe
//
//  Created by Federico on 11/01/2022.
//

import SwiftUI

struct Map2: View {
    @State private var moves = ["","","","","","","","","","","","","","","",""]
    @State private var endGameText = "TicTac"
    @State private var gameEnded = false
    private var ranges =  [(0..<4),(4..<8),(8..<12),(12..<16)]
    @State private var highscore = UserDefaults.standard.integer(forKey: "highscore")
    @State private var score = 100
    @State private var basescore = 10
    @State private var minusscore = 80
    @State private var realscore = 0
    let columnLayout = Array(repeating: GridItem(.fixed(80), spacing: 15, alignment: .center), count: 4)
        
    
    
    var body: some View {
        ZStack {
            Backgroundcolor()
            ScrollView {
                    VStack {
                        HStack {
                            Text(endGameText)
                                .font(.system(size: 25))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .alert(endGameText, isPresented: $gameEnded) {
                                    Button("Continue playing", action: continueplay)
                                }
                        }
                        HStack {
                            HStack{
                                Text("Score: \(realscore)")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    
                            }
                            .frame(width: 100, alignment: .leading)
                            .padding()
                            
                            HStack{
                                Text("High Score: \(highscore)")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 100, alignment: .trailing)
                            .padding(.trailing, 10)
                            .padding(.leading, 55)
                        }
                        Spacer()
                            ForEach(ranges, id: \.self) { range in
                                LazyVGrid(columns: columnLayout) {
                                    ForEach(range, id: \.self) { i in
                                        XOButton(letter: $moves[i])
                                            .simultaneousGesture(
                                                TapGesture()
                                                    .onEnded { _ in
                                                        print("Tap: \(i)")
                                                        playerTap(index: i)
                                                    }
                                            )
                                    }
                                }
                            }
                            .padding()
                        Spacer()
                        HStack{
                            Button("Reset") {
                                resetGame()
                            }
                            .padding()
                            
                            Button("Reset if draw") {
                                Resettemp()
                            }
                            .modifier(Buttonfunction(color: Color("Blue")))
                            .modifier(Shadow())
                            .padding()
                        }
                        .padding(.top, 40)
                    }
            }
        }
    }
    
    //Function
    func playerTap(index: Int) {
        if (moves[index] == "") {
            moves[index] = "X"
            botMove()
            //botMove()
        }
        
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGameText = "\(letter) has won!"
                gameEnded = true
                break
            }
        }
        
        
    }
    
    func botMove() {
        var availableMoves: [Int] = []
        var movesLeft = 0
        
        // Check the available moves left
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        // Make sure there are moves left before bot moves
        if availableMoves.count != 0 {
            moves[availableMoves.randomElement()!] = "O"
        }
        
        //If there are no moves left for bot moves, the game will automatically reset
        if (availableMoves.count == 1){
            //Set delay timer to delay the reset function to prevent reseting the game before the final move from both side
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)){
                Resettemp()
            }
        }
        // Logging
        print(availableMoves)
    }
    
    func newHighScore(){
        highscore = realscore
        UserDefaults.standard.set(highscore, forKey: "highscore")
        playSound(sound: "highscore", type: "mp3")
    }
    
    func Realscore(){
        realscore = score
    }
    
    func playLoses() {
        realscore -= minusscore
    }
    
    func playerWins() {
        if (realscore >= 200){
            realscore += basescore * 10
            score += basescore * 10
        }
        if (realscore >= 0 && realscore < 200){
            realscore += basescore * 10
        }
        if (realscore < 0){
            realscore += basescore
        }
    }
    
    func Resettemp(){
        moves = ["","","","","","","","","","","","","","","",""]
    }
    
    func resetGame(){
        endGameText = "TicTac"
        moves = ["","","","","","","","","","","","","","","",""]
        UserDefaults.standard.set(0, forKey: "highscore")
        highscore = 0
        score = 100
        realscore = 0
    }
    
    //Continue play function
    func continueplay(){
        moves = ["","","","","","","","","","","","","","","",""]
        endGameText = "TicTac"
    }
    
    func checkWinner(list: [String], letter: String) -> Bool {
        let winningSequences = [
            // Diagonals
            [ 0, 5, 10, 15], [ 3, 6, 9, 12 ],
            // Vertical 5 rows
            [ 0, 4, 8, 12 ], [ 1, 5, 9, 13 ], [ 2, 6, 10, 14 ], [ 3, 7, 11, 15 ],
            // Horizontal 5 rows
            [ 0, 1, 2, 3], [ 4, 5, 6, 7 ], [ 8, 9, 10, 11 ], [ 12, 13, 14, 15 ]
        ]
        
        
        for sequence in winningSequences {
            var scores = 0
            
            for match in sequence {
                if list[match] == letter {
                    scores += 1
                    
                    if scores == 4 {
                        if (letter == "X"){
                            print("\(letter) has won!")
                            playerWins()
                            if (realscore > 0 && score >= highscore){
                                newHighScore()
                            } else {
                                playSound(sound: "winning", type: "mp3")
                            }
                            return true
                        }
                        if (letter == "O"){
                            print("You lose")
                            playSound(sound: "gameover", type: "mp3")
                            playLoses()
                            return true
                        }
                    }
                    
                }
            }
        }
        return false
    }
    
}

struct Map2_Previews: PreviewProvider {
    static var previews: some View {
        Map2()
    }
}
