//
//  ContentView.swift
//  PokemonTrivia
//
//  Created by JoeChanges on 5/14/21.
//

import SwiftUI
import PokemonAPI

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

struct ContentView: View {
    @State private var poke:String = ""
    
    func getPokemon() {
        let randomNum = Int.random(in: 1 ..< 898)
        PokemonAPI().pokemonService.fetchPokemon(randomNum) { result in
            switch result {
            case .success(let pokemon):
                self.poke = pokemon.sprites?.frontDefault ?? "Empty"// bulbasaur
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        VStack {
            Image("poke")
                .resizable()
                .scaledToFit()
                .padding(20)
            Image(uiImage: poke.load())
                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .resizable()
                .frame(width: 200, height: 200)
                .clipped()
            
            VStack() {
                VStack(spacing: 20) {
                    Button(action: {
                        getPokemon()
                    }){
                        HStack {
                            Text("Bulbusaur")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.secondary)
                        .cornerRadius(40)
                        
                    }
                        
                    Button(action: {
                        getPokemon()
                    }){
                        HStack {
                            Text("Squirtle")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.secondary)
                        .cornerRadius(40)
                    }
                        
                    Button(action: {
                        getPokemon()
                    }){
                        HStack {
                            Text("Charmander")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.secondary)
                        .cornerRadius(40)
                    }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
