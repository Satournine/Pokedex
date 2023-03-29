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
    
    private let pokemon: PokemonDetails
    
    var name: String {
        return pokemon.name.capitalized
    }
    
    var typeOne: String {
        return pokemon.types[0].type.name.capitalized
    }
    
    var typeTwo: String? {
        if pokemon.types.count > 1 {
            return pokemon.types[1].type.name.capitalized
        } else {
            return nil
        }
    }
    
    var imageUrl: URL? {
        return URL(string: pokemon.sprites.url)
    }
    
    init(pokemon: PokemonDetails) {
        self.pokemon = pokemon
    }
    
    func updateBackgroundColor() -> UIColor {
        // Add logic to update background color based on type
        return UIColor.white
    }
    
    func updateModel() {
        // Add logic to update the Model if needed
    }
}
