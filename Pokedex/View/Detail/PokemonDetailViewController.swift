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
    var viewModel: PokemonDetailViewModel?
        var backgroundColor: UIColor?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            guard let pokemon = pokemon else{
                fatalError("PokemonDetailView failed")
            }
            viewModel = PokemonDetailViewModel(pokemon: pokemon)
            setupViews()
        }
        
        func setupViews() {
            guard let viewModel = viewModel else { return }
            
            PokeName.text = viewModel.name
            PokeTypeOne.text = viewModel.typeOne
            PokeTypeTwo.text = viewModel.typeTwo
            PokeTypeTwo.isHidden = viewModel.typeTwo == nil
            if let url = viewModel.spriteURL {
                self.ImageDetailView.kf.setImage(with: url)
            }
            
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
    }
