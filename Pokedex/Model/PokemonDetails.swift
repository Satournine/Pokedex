//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by user226229 on 13.03.2023.
//

import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let order: Int
    let sprites: Sprite
    let types: [PokemonType]
}

struct PokemonType: Codable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
}


struct Sprite: Codable {
    let url: String

    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

