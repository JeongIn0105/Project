//
//  ViewController.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

import UIKit
import SnapKit
import Then
import RxSwift

// MARK: - Step 4. MainViewController 구현
class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private var pokemon = [Pokemon]()
    
    // MARK: - UIKit 설정
    private let titleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "pokemonBall")
    }
    
    private lazy var collectonView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.id)
        
        $0.delegate = self
        $0.dataSource = self
        
        $0.backgroundColor = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        bind()
    }
    
    // MARK: - 네비게이션 바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - 포켓몬 메인 화면 UI 구성
    private func configureUI() {
        
        view.backgroundColor = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
        
        [titleImageView, collectonView].forEach { view.addSubview($0) }
        
        titleImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        
        collectonView.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    // MARK: - 컬렉션 뷰의 구성요소 Section, 그룹, 아이템 레이아웃 설정
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/3.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(130)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    // MARK: - ViewModel과 ViewController를 이어주는 함수인 bind() 메서드 작성
    private func bind() {
        
        viewModel.pokemonRelay // Challenge - Relay 코드 수정
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pokemons in
                
                // MARK: - Step 8. 무한 스크롤 기능 추가
                let before = self?.pokemon.count ?? 0 // 기존 데이터 개수 확인.
                self?.pokemon = pokemons // 새 데이터로 업데이트.
                
                if before == 0 {
                    self?.collectonView.reloadData() // 처음 로딩이면 reloadData()
                } else {
                    let indexPaths = (before..<pokemons.count).map { IndexPath(item: $0, section: 0) } // // 새로 추가된 셀 위치 계산.
                    self?.collectonView.insertItems(at: indexPaths) // 스크롤 했을 때 추가 데이터면 insertItems()로 아래 셀만 추가.
                }
                
            }, onError: { error in
                print("에러 발생: \(error)")
            }).disposed(by: disposeBag)
    }
}

// MARK: - 컬렉션 뷰의 Delegate 설정
extension MainViewController: UICollectionViewDelegate {
    
    // MARK: 컬렉션 뷰의 셀을 클릭했을 때 반응하는 메서드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // MARK: - Step 5. CollectionViewCell 을 클릭했을 때 화면 전환
        let selectedPokemon = pokemon[indexPath.row]
        
        let detailViewController = DetailViewController(pokemon: selectedPokemon)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Step 8. 무한 스크롤 기능 추가
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height - 100 {
            viewModel.fetchPokemon()
        }
        
    }
}

// MARK: - 컬렉션 뷰의 DataSource 설정
extension MainViewController: UICollectionViewDataSource {
    
    // MARK: 컬렉션 뷰의 섹션이 몇 개인지를 설정하는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    // MARK: 각각의 cell을 indexPath마다 어떤 cell 타입으로 지정해 줄 건지 정하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCell.id, for: indexPath) as? PosterCell else {
            return UICollectionViewCell()
        }
        
        let pokemon = pokemon[indexPath.row]
        cell.configure(with: pokemon)
        
        return cell
    }
    
}
