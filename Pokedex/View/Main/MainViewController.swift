//
//  ViewController.swift
//  Pokedex
//
//  Created by user226229 on 5.03.2023.
//

import UIKit
class MainViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    let viewModel = PokemonViewModel()
    private var response: [PokemonDetails] = []
    var filteredResponse: [PokemonDetails] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        
        UINavigationBar.appearance().standardAppearance = appearance // for scrolling bg color
        UINavigationBar.appearance().compactAppearance = appearance // not sure why it's here, but u can remove it and still works
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // for large title bg color
        setupSearchControler()
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
    
    fileprivate func setupSearchControler(){
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = search
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2{
            isSearching = true
            filteredResponse = response.filter({$0.name.range(of: searchText, options: .caseInsensitive) != nil})
        } else {
            isSearching = false
            filteredResponse.removeAll()
        }
        collectionView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}

extension MainViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredResponse.count : response.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokedexCollectionViewCell", for: indexPath) as! PokedexCollectionViewCell
        //cell.setup()
        let pokemon = isSearching ? filteredResponse[indexPath.row] : response[indexPath.row]
        cell.configure(with: pokemon)
        
        return cell
    }
    
    
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 2, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width/2.1
        let height = view.frame.height/4.3
        return CGSize(width: width, height: height)
    }
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PokedexCollectionViewCell
        
        let selectedPokemon = isSearching ? filteredResponse[indexPath.row] : response[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailBoard") as? PokemonDetailViewController else{return}
        detailsVC.pokemon = selectedPokemon
        detailsVC.backgroundColor = cell.backgroundColor
        print(cell.backgroundColor ?? .white)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
