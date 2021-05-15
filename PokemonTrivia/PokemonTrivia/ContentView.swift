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
            Text("Who's that pokemon?")
//            Image(systemName: "pencil")
//                .renderingMode(.original)
            Image(uiImage: poke.load())
                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .resizable()
                .frame(width: 200, height: 200)
                .clipped()
            Spacer()
            VStack(spacing: 100) {
                HStack(spacing: 100) {
                    Button(action: {
                        getPokemon()
                    }){
                        Text("Bulbusaur")
                    }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

                    Button(action: {
                        getPokemon()
                    }){
                        Text("Squirtle")
                    }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                }

                HStack(spacing: 100) {
                    Button(action: {
                        getPokemon()
                    }){
                        Text("Charmander")
                    }
                        .background(Color.red)
                        .foregroundColor(Color.white)

                    Button(action: {
                        getPokemon()
                    }){
                        Text("Mankey")
                    }                        .background(Color.red)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
        }
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
