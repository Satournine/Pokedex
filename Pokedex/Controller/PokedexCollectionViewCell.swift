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
    
    
    func setup(){
        PokemonImageView.backgroundColor = .purple
        PokemonNameLabel.text = "Squirtle"
        PokemonNoLabel.text = "151"
       
    }
    
    func configure(with pokemon: PokemonDetails){
        PokemonImageView.alpha = 0
        PokemonNameLabel.alpha = 0
        PokemonNoLabel.alpha = 0
        //let pokemon = response[indexPath.row]
        PokemonNameLabel.text = pokemon.name
        PokemonNoLabel.text = String(pokemon.id)
        DispatchQueue.main.async{
                if let url = URL(string: pokemon.sprites.url){
                    self.PokemonImageView.kf.setImage(with: url)
                    KingfisherManager.shared.retrieveImage(with: url) { result in
                    switch result{
                    case.success(let value):
                        let colors = value.image.getColors()
                        self.PokemonImageView.backgroundColor = colors?.background
                    case.failure(let error):
                        print(error)
                    }
                }
            }
            UIView.animate(withDuration: 0.3) {
                self.PokemonImageView.alpha = 1
                self.PokemonNameLabel.alpha = 1
                self.PokemonNoLabel.alpha = 1
            }
            
        }
        
        
        
        
        
    }
    
    
    
    
    
}
