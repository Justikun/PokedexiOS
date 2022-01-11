//
//  PokemonError.swift
//  PokedexiOS
//
//  Created by Justin Lowry on 1/4/22.
//

import Foundation

enum PokemonError: LocalizedError {
    // What we see as a developer
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    // What the user sees
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach PokeAPI.co"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server reponseded with no data."
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
