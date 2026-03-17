//
//  PosterCell.swift
//  ChallengeProject
//
//  Created by 이정인 on 3/13/26.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class PosterCell: UICollectionViewCell {
    
    static let id = "PosterCell"
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0)
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 셀 버벅임 현상 해결
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask() // Challenge Kingfisher 코드 추가(설명 : 이전 이미지 다운로드를 중단하는 코드)
        posterImageView.image = nil
    }
    
    // MARK: - 포켓몬 이미지 URL 메서드 생성(메인 화면)
    func configure(with pokemon: Pokemon) {
        
        guard let pokemonID = pokemon.id else { return }
        
        let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonID).png"
        
        guard let url = URL(string: urlString) else { return }
        
        // MARK: - Challenge Kingfisher 활용
        posterImageView.kf.setImage(with: url)
    }
}
