//
//  PokedexCollectionViewCell.swift
//  Pokedex
//
//  Created by user226229 on 6.03.2023.
//

import UIKit
import Kingfisher
import UIImageColors

class PokedexCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var PokemonImageView: UIImageView!
    @IBOutlet weak var PokemonNameLabel: UILabel!
    @IBOutlet weak var PokemonNoLabel: UILabel!
    
    let viewModel = PokemonViewModel()
    
    
    override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = 20
            layer.masksToBounds = true
        }
    

    
    func setup(){
        PokemonImageView.alpha = 0
        PokemonNameLabel.alpha = 0
        PokemonNoLabel.alpha = 0
        backgroundColor = .white
       
    }
    
    func configure(with pokemon: PokemonDetails){
        print(pokemon)
        //let pokemon = response[indexPath.row]
        PokemonNameLabel.text = pokemon.name.capitalized
        PokemonNoLabel.text = "#\(pokemon.id)"
        
        viewModel.retrievePokemonImage(with: pokemon.sprites.url){ image, colors in
            DispatchQueue.main.async {
                self.PokemonImageView.image = image
                self.backgroundColor = colors?.background
                
                UIView.animate(withDuration: 0.4) {
                                self.PokemonImageView.alpha = 1
                                self.PokemonNameLabel.alpha = 1
                                self.PokemonNoLabel.alpha = 1
                            }
            }
            
        }
        
    }
    
    
    
    
    
}
