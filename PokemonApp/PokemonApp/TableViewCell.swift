//
//  TableViewCell.swift
//  PokemonApp
//
//  Created by 이정인 on 2/19/26.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    // 테이블 뷰 셀은 각자의 고유한 아이디를 가지고 있어야만 한다. -> static 한 프로퍼티.
    static let id = "TableViewCell"
    
    private let pokemonImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        
        return label
        
    }()
    
    private let phoneNumberLabel: UILabel = {
        
        let label = UILabel()
        label.text = "010-0000-0000"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.backgroundColor = .white
        
        [pokemonImageView, nameLabel, phoneNumberLabel].forEach { contentView.addSubview($0) }
        
        // MARK: TableViewCell의 제약 조건.
        pokemonImageView.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(24)
            
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(pokemonImageView.snp.centerY)
            $0.leading.equalTo(pokemonImageView.snp.trailing).offset(24)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(pokemonImageView.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        
    }
    
    
    func configureCell(phoneBookData: PhoneBook) {
        self.nameLabel.text = phoneBookData.name
        self.phoneNumberLabel.text = phoneBookData.phoneNumber
        if let imageData = phoneBookData.image {
            self.pokemonImageView.image = UIImage(data: imageData, scale: 1.3)
        }
    }
    
}
