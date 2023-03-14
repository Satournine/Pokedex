//
//  PokemonData.swift
//  Pokedex
//
//  Created by user226229 on 11.03.2023.
//

import Foundation


struct PokemonData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}


