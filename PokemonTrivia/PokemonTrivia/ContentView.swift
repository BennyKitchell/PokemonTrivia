//
//  ContentView.swift
//  PokemonTrivia
//
//  Created by JoeChanges on 5/14/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("What Pokemon is this?")
            Image(systemName: "pencil")
                .renderingMode(.original)
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
                        //something happens
                    }){
                        Text("Mankey")
                    }                        .background(Color.red)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
