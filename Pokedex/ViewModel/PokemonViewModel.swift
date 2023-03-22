//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by user226229 on 12.03.2023.
//

import Foundation
import Alamofire
import Kingfisher
import UIImageColors


class PokemonViewModel{
    
    private let baseURL = "https://pokeapi.co/api/v2/pokemon?limit=151&offset=0"
    var pokemonData: PokemonData?
    var pokemonDetails: PokemonDetails?
    //var detailURL: String?
    
    
    func fetchPokemon(completion: @escaping (Result<PokemonDetails, Error>) -> Void){
        AF.request(baseURL).responseDecodable(of: PokemonData.self) { response in
            switch response.result{
            case .success(let data):
                self.pokemonData = data
                for eachResult in data.results{
                    let detailURL = eachResult.url
                    print(detailURL)
                    AF.request(detailURL).responseDecodable(of:PokemonDetails.self){ detailResponse in
                            switch detailResponse.result{
                            case .success(let pokeData):
                                print(pokeData)
                                completion(.success(pokeData))
                            case .failure(let error):
                                print("Error Here\(error)")
                            }
                        }
                    
                }
          
            case .failure(let error):
                completion(.failure(error))
            }
        
        }
    }
    
    func fetchSprite(completion: @escaping (Result<PokemonDetails, Error>) -> Void){
        AF.request("https://pokeapi.co/api/v2/pokemon/45/").responseDecodable(of:PokemonDetails.self){ detailResponse in
                switch detailResponse.result{
                case .success(let pokeData):
                    print(pokeData)
                    completion(.success(pokeData))
                case .failure(let error):
                    print("Error Here\(error)")
                }
            }
    }
    
    func retrievePokemonImage(with urlString: String, completion: @escaping(UIImage?, UIImageColors?) -> Void){
        guard let url = URL(string: urlString) else{
            completion(nil,nil)
            return
        }
        DispatchQueue.main.async {
            
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result{
                case .success(let value):
                    let colors = value.image.getColors()
                    completion(value.image, colors)
                case .failure(let error):
                    print(error)
                    completion(nil,nil)
                }
            }
        }
    }
    
}
