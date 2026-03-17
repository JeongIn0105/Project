//
//  Pokemon.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

/*
 1. **`limit` 개씩 `offset` 부터 포켓몬 정보 로드**
     - `https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)`
     - 예를들어, limit = 20, offset = 0 이라면 처음부터 20개의 포켓몬 정보를 업로드.
 
 2. **포켓몬 번호로부터 포켓몬 디테일 정보 로드**
     - `https://pokeapi.co/api/v2/pokemon/\(pokemon_id)/`
 */

// MARK: - Step 2. Model 구현
import Foundation

// MARK: - 포켓몬 메인 화면

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
    
    // MARK: - 포켓몬 API URL에서 포켓몬 ID 추출(이 코드 없으면 이미지 안 나온다)
    var id: Int? {
        let pokemonURL = url.hasSuffix("/") ? String(url.dropLast()) : url
        return Int(pokemonURL.components(separatedBy: "/").last ?? "")
    }
}

// MARK: - 포켓몬 상세 화면

struct PokemonDetail: Codable {
    let id: Int // No
    let name: String // 이름
    let types: [PokemonTypeEntry] // 타입
    let height: Int // 키
    let weight: Int // 몸무게
}

// MARK: - 타입

struct PokemonTypeEntry: Codable {
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

// MARK: - Pokemon 완료!!!
