//
//  DetailViewModel.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

import Foundation
import RxSwift
import RxRelay

// MARK: - Step 6. DetailViewModel 구현
class DetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: 포켓몬 상세 정보를 ViewController로 전달
    let pokemonDetailRelay = BehaviorRelay<PokemonDetail?>(value: nil) // Challenge - Relay 코드 수정
    
    // MARK: - 어떤 포켓몬의 상세 정보를 가져올지 알기 위해 저장하는 변수
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        fetchPokemonDetail()
    }
    
    // MARK: - 포켓몬 상세 정보 가져오기
    func fetchPokemonDetail() {
        
        guard let pokemonId = pokemon.id else { return }
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)/") else {
            return // Challenge - Relay 코드 수정
        }
        
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (pokemonDetail: PokemonDetail) in
                self?.pokemonDetailRelay.accept(pokemonDetail) // Challenge - Relay 코드 수정
            }, onFailure: { error in
                print("에러 발생: \(error)") // Challenge - Relay 코드 수정
            }).disposed(by: disposeBag)

    }
    
}
// MARK: - DetailViewModel 완료!!!
