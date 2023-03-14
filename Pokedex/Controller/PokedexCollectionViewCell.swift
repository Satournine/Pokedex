//
//  PokedexCollectionViewCell.swift
//  Pokedex
//
//  Created by user226229 on 6.03.2023.
//

import UIKit
import Kingfisher

class PokedexCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var PokemonNameLabel: UILabel!
    @IBOutlet weak var PokemonNoLabel: UILabel!
    
    
    func setup(){
        PokemonImageView.backgroundColor = .purple
        PokemonNameLabel.text = "Squirtle"
        PokemonNoLabel.text = "151"
    }
    
    func configure(with pokemon: PokemonDetails){
        
        //let pokemon = response[indexPath.row]
        PokemonNameLabel.text = pokemon.name
        PokemonNoLabel.text = String(pokemon.id)
        if let url = URL(string: pokemon.sprites.url){
            PokemonImageView.kf.setImage(with: url)
        }
        
        
    }
    
    
    
    
    
}
