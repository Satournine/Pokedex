//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by user226229 on 18.03.2023.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    @IBOutlet weak var ImageDetailView: UIImageView!
    @IBOutlet weak var PokeName: UILabel!
    @IBOutlet weak var PokeTypeOne: UILabel!
    @IBOutlet weak var PokeTypeTwo: UILabel!
    
    var pokemon: PokemonDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetails()

        
    }
    
    func setupDetails(){
        PokeName.text = pokemon?.name.capitalized
        PokeTypeOne.text = pokemon?.types[0].type.name.capitalized
        guard let counter = pokemon?.types.count else {return}
        if counter > 1 {
            PokeTypeTwo.text = pokemon?.types[1].type.name.capitalized} else{ PokeTypeTwo.text = nil}
        if let url = URL(string: pokemon!.sprites.url){
            self.ImageDetailView.kf.setImage(with: url)
        }
    }

}
