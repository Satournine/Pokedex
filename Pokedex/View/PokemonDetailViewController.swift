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
    @IBOutlet var detailUIView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var pokemon: PokemonDetails?
    var backgroundColor: UIColor?
    let capsuleView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetails()

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        view.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        //stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        PokeName.backgroundColor = backgroundColor
        PokeName.layer.cornerRadius = 5
        PokeName.clipsToBounds = true
        
        PokeTypeOne.backgroundColor = backgroundColor
        PokeTypeOne.layer.cornerRadius = 15
        PokeTypeOne.clipsToBounds = true
        
        PokeTypeTwo.backgroundColor = backgroundColor
        PokeTypeTwo.layer.cornerRadius = 15
        PokeTypeTwo.clipsToBounds = true
        
  
    }
    
    func setupDetails(){
        PokeName.text = pokemon?.name.capitalized
        PokeTypeOne.text = pokemon?.types[0].type.name.capitalized
        guard let counter = pokemon?.types.count else {return}
        if counter > 1 {
            PokeTypeTwo.text = pokemon?.types[1].type.name.capitalized} else{ PokeTypeTwo.isHidden = true}
        if let url = URL(string: pokemon!.sprites.url){
            self.ImageDetailView.kf.setImage(with: url)
        }
    }

}
