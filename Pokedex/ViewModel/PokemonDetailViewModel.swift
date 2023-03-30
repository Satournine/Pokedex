//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by user226229 on 30.03.2023.
//

import Foundation
import UIImageColors
import UIKit

class PokemonDetailViewModel {
    var pokemon: PokemonDetails?
    let name: String
    let typeOne: String
    let typeTwo: String?
    let spriteURL: URL?
    
    init(pokemon: PokemonDetails) {
        self.name = pokemon.name.capitalized
        print(self.name)
        self.typeOne = pokemon.types[0].type.name.capitalized
        if pokemon.types.count > 1 {
            self.typeTwo = pokemon.types[1].type.name.capitalized
        } else {
            self.typeTwo = nil
        }
        if let url = URL(string: pokemon.sprites.url) {
            self.spriteURL = url
        } else {
            self.spriteURL = nil
        }
    }
}
