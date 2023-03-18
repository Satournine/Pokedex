//
//  ViewController.swift
//  Pokedex
//
//  Created by user226229 on 5.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = PokemonViewModel()
    private var response: [PokemonDetails] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        fetchPokemon()

       
    }
    
    fileprivate func fetchPokemon() {
        viewModel.fetchPokemon { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                print(data)
                self.response.append(data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MainViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokedexCollectionViewCell", for: indexPath) as! PokedexCollectionViewCell
        //cell.setup()
        response.sort { $0.order < $1.order }
        cell.configure(with: response[indexPath.row])
        
        return cell 
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Test")
    }
}
