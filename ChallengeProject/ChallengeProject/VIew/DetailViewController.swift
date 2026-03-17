//
//  DetailViewController.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

import UIKit
import SnapKit
import Then
import RxSwift
import Kingfisher

// MARK: - Step 7. DetailViewController 구현
final class DetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let detailViewModel: DetailViewModel // Step 7
    
    // MARK: - Step 5. CollectionViewCell 을 클릭했을 때 화면 전환
    private var pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.detailViewModel = DetailViewModel(pokemon: pokemon) // Step 7.
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIKit 설정
    private let cardView = UIView().then {
        $0.backgroundColor = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let pokemonImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let noLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 30)
    }
    
    private let nameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 30)
    }
    
    private let typeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let heightLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let weightLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    // MARK: - 생명 주기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    
    // MARK: - 네비게이션 바 다시 보이게 구현
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - 포켓몬 상세 화면 UI 구성
    private func configureUI() {
        
        view.backgroundColor = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
        navigationItem.title = ""
        
        view.addSubview(cardView)
        [pokemonImageView,
         typeLabel,
         heightLabel,
         weightLabel
        ].forEach { cardView.addSubview($0) }
        
        cardView.addSubview(stackView)
        [noLabel, nameLabel].forEach { stackView.addArrangedSubview($0) }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        pokemonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(pokemonImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        heightLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(heightLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - detailViewModel과 DetailViewController를 이어주는 함수인 bind() 메서드 작성
    private func bind() {
        detailViewModel.pokemonDetailRelay // Challenge - Relay 코드 수정
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pokemonDetail in
                guard let self = self,
                      let pokemonDetail = pokemonDetail else { return }
                
                self.noLabel.text = "No.\(pokemonDetail.id)"
                
                // 이름 : 영문 이름을 한글 이름으로 변환
                self.nameLabel.text = PokemonTranslator.getKoreanName(for: pokemonDetail.name)
                
                // 타입 : 타입 배열을 한글로 바꾸고 문자열로 합침
                self.typeLabel.text = "타입: " + pokemonDetail.types.compactMap {
                    PokemonTypeName(rawValue: $0.type.name)?.displayName
                }.joined(separator: ", ")
                
                self.heightLabel.text = "키: \(Double(pokemonDetail.height) / 10.0)m" // 키 : height / 10
                self.weightLabel.text = "몸무게: \(Double(pokemonDetail.weight) / 10.0)kg" // 몸무게 : weight / 10
                
                // MARK: - Challenge Kingfisher를 활용하여 포켓몬 id로 이미지 로드
                if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonDetail.id).png") {
                    self.pokemonImageView.kf.setImage(with: url)
                }
                
            }, onError: { error in
                print("에러 발생: \(error)")
            }).disposed(by: disposeBag)
    }
    
}
