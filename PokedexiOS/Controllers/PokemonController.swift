//
//  PokemonController.swift
//  PokedexiOS
//
//  Created by Justin Lowry on 1/4/22.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndPoint = "pokemon"
    
    static func fetchPokemon(searchterm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        // 1 - URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let searchTermURL = pokemonURL.appendingPathComponent(searchterm.lowercased())
        print(searchterm)
                
        // 2 - Datatask
        URLSession.shared.dataTask(with: searchTermURL) { data, response, error in
            // 3 - Error Handling
            if let error = error {
                print("URLSession Error", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Data Check
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // 5 - Decode Data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print("Error Decoding", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    static func fetchSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        // 1 - URL
        let spriteURL = pokemon.sprites.classicSpriteURL
        
        // 2 - Datatask
        URLSession.shared.dataTask(with: spriteURL) { data, _, error in
            // 3 - Error Handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Data Check
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            // 5 - Decode Data
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(sprite))
            
        }.resume()
    }
}
