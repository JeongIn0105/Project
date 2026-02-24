//
//  PokemonData.swift
//  PokemonApp
//
//  Created by 이정인 on 2/20/26.
//

/*
 {
   "id": 25,
   "name": "pikachu",
   "height": 4,
   "weight": 60,
   "sprites": {
     "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
   }
 }
 */

import Foundation

struct PokemonData: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: URL?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
