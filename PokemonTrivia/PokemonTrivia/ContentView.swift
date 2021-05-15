//
//  ContentView.swift
//  PokemonTrivia
//
//  Created by JoeChanges on 5/14/21.
//

import SwiftUI
import PokemonAPI

struct ContentView: View {
    @State private var poke:String = ""
    
    func getPokemon() {
        let randomNum = Int.random(in: 1 ..< 152)
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
            Text("What Pokemon is this?")
//            Image(systemName: "pencil")
//                .renderingMode(.original)
            
            Spacer()
            VStack(spacing: 100) {
                HStack(spacing: 100) {
                    Button(action: {
                        //something happens
                    }){
                        Text("Bulbusaur")
                    }
                        .background(Color.red)
                        .foregroundColor(Color.white)

                    Button(action: {
                        //something happens
                    }){
                        Text("Squirtle")
                    }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                }

                HStack(spacing: 100) {
                    Button(action: {
                        //something happens
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
