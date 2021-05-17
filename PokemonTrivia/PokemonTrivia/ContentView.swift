//
//  ContentView.swift
//  PokemonTrivia
//
//  Created by Benny Kitchell on 5/14/21.
//

import SwiftUI
import PokemonAPI
//@TODO: Code Cleanup
//@TODO: Minimize api calls with improved API fetch
//@TODO: Add a timer for automatic failure case

// Extension from tutorial by  Adnan Afzal
extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self)
            else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        }
        catch {
            print("Image was not processed by URL")
            return UIImage()
        }
    }
}

struct ButtonModifier: View {
    var buttonText: String
    
    var body: some View {
        HStack {
            Text("\(buttonText)")
        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.secondary)
            .cornerRadius(40)
    }
}

struct ContentView: View {
    @State private var pokeAnswer:String = ""
    @State private var pokeSprite = ""
    @State private var pokeArray: [String] = []
    @State var userScore = 0
    @State var highScore = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("poke")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                
                Image(uiImage: pokeSprite.load())
                    .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipped()
                
                VStack() {
                    if (pokeArray.count > 2) {
                        VStack(spacing: 20) {
                            ForEach(0 ..< 3) { index in
                                Button(action: {
                                    checkAnswer(index: index)
                                }){
                                    ButtonModifier(buttonText: pokeArray[index])
                                }
                            }
                        }
                        
                        Text("High Score: \(highScore)")
                            .padding(20)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
                Spacer()
            }
                .background(
                LinearGradient(gradient: Gradient(colors: [.red, .white, ]), startPoint: .top, endPoint: .bottom)
                )
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onAppear() {
                    getPokemon()
                }
        }
                .alert(isPresented: $showingScore) { Alert( title: Text("\(scoreTitle)"), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                    self.getPokemon()
                })
            }
        
    }
    
    func checkAnswer(index: Int) {
        if (pokeArray[index] == pokeAnswer) {
            scoreTitle = "Correct!"
            userScore += 1
            if(userScore > highScore){
                highScore = userScore
            }
        } else {
            scoreTitle = "Sorry, the correct answer is \(pokeAnswer)"
            userScore = 0
        }
        
        showingScore = true
    }
    
    func pushPokemonIntoArray(name: String) {
        pokeArray.append(name)
    }
    
    func getPokemon() {
        pokeArray.removeAll()
        for index in 0 ..< 3 {
            let randomNum = Int.random(in: 1 ..< 898)
            PokemonAPI().pokemonService.fetchPokemon(randomNum) { result in
                switch result {
                case .success(let pokemon):
                    if (index == 0) {
                        self.pokeSprite = pokemon.sprites?.frontDefault ?? "Empty"
                        self.pokeAnswer = pokemon.name?.capitalized ?? "Empty"
                    }
                    pushPokemonIntoArray(name: pokemon.name?.capitalized ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        self.pokeArray.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
