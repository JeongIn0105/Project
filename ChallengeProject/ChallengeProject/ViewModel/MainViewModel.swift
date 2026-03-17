//
//  MainViewModel.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

import Foundation
import RxSwift
import RxRelay

// MARK: - Step 3. MainViewModel 구현
class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - 리스트 형태로 포켓몬 정보들을 가져오기
    let pokemonRelay = BehaviorRelay<[Pokemon]>(value: []) // Challenge - Relay 코드 수정
    
    // MARK: limit = 20, offset = 0 설정(Step 3에서 20개의 포켓몬 정보만 불러와도 됩니다.)
    private let limit = 20
    private var offset = 0
    
    // MARK: - Step 8. 무한 스크롤 기능 추가
    private var isLoading = false
    private var pokemonList = [Pokemon]()
    
    init() {
        fetchPokemon()
    }
    
    // MARK: - 포켓몬 정보 가져오기(RxSwift 활용)
    func fetchPokemon() {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            return // Challenge - Relay 코드 수정
        }
        
        // MARK: - Step 8. 무한 스크롤 기능 추가
        if isLoading { return }
        isLoading = true
        
        // MARK: - NetworkManager 활용
        NetworkManager.shared.fetch(url: url)
            .subscribe(onSuccess: { [weak self] (pokemonResponse: PokemonResponse) in
                
                // // MARK: - Step 8. 무한 스크롤 기능 추가
                guard let self = self else { return }
                
                self.pokemonList += pokemonResponse.results
                self.pokemonRelay.accept(self.pokemonList) // Challenge - Relay 코드 수정
                self.offset += self.limit
                self.isLoading = false
                
            }, onFailure: { [weak self] error in
                print("에러 발생: \(error)") // Challenge - Relay 코드 수정
                self?.isLoading = false // Step 8. 무한 스크롤 기능 추가
            }).disposed(by: disposeBag)
    }
}

// MARK: - MainViewModel 완료!!!
