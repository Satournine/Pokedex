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
        collectionView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
       
        self.fetchPokemon()
        
        

       
    }
    
    fileprivate func fetchPokemon() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.viewModel.fetchPokemon { [weak self] result in
                guard let self = self else { return }
                switch result{
                case .success(let data):
                    //print(data)
                    self.response.append(data)
                    self.response.sort{$0.order < $1.order}
                    DispatchQueue.main.async {
//                        let indexPaths = (currentCount..<self.response.count).map{IndexPath(row: $0, section: 0)}
//                        self.collectionView.insertItems(at: indexPaths)
                        self.collectionView.reloadData()
                        
                    }
                case .failure(let error):
                    print(error)
                }
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
        
        cell.configure(with: response[indexPath.row])
        
        return cell 
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 195)
    }
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let selectedPokemon = response[indexPath.row]
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailBoard") as? PokemonDetailViewController else{return}
       detailsVC.pokemon = selectedPokemon
       navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
