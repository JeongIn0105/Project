//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이정인 on 1/23/26.
//

// 계산기 앱 만들기
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Level 1. UILabel 사용.
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .black // 뷰의 배경화면 색은 검은색.
        
        // Label의 속성
        label.text = "12345" // 우선, 텍스트는 12345로 고정.
        label.textColor = .white // 텍스트의 색상은 하얀색.
        label.textAlignment = .right // 텍스트의 정렬은 오른쪽 정렬.
        label.font = UIFont.boldSystemFont(ofSize: 60) // 폰트는 bold체, 사이즈는 60.
        
        view.addSubview(label)
        
        // Label의 제약 조건.
        label.snp.makeConstraints {
            $0.height.equalTo(100) // Label의 높이는 100으로 설정.
            $0.leading.trailing.equalToSuperview().offset(-30) // leading, trailing는 뷰로 부터 30 떨어지도록 설정.
            $0.top.equalToSuperview().offset(200) // top은 뷰로 부터 200 떨어지도록 설정.
        }
        
        
        // Level 2. UIStackView을 사용해서 4개의 버튼을 모아 가로 스택 뷰 생성.
        let buttonTitles = ["7", "8", "9", "+"] // titles 상수 안에 배열 형식으로 숫자 7, 8, 9, +를 넣어줌.
        
        let buttons = buttonTitles.map { titles in // buttonTitles 배열의 각 문자열("7", "8", "9", "+")을 하나씩 꺼내서 buttons에 UIButton 형태로 배열이 저장됨.
            
            makeButton(title: titles)
        }
        
        let horizontalStackView = makeHorizontalStackView(buttons) // 방금 만든 버튼 배열을 전달해서 버튼 4개가 가로로 정렬된 UIStackView를 생성.
        view.addSubview(horizontalStackView)
        
        // horizontalStackView의 제약 조건
        horizontalStackView.snp.makeConstraints {
            $0.height.equalTo(80) // StackView의 높이를 80만큼 설정.
            $0.leading.trailing.equalToSuperview().inset(36) // View로 부터 왼쪽과 오른쪽으로 부터 36만큼 떨어지게 설정.
            $0.top.equalTo(label.snp.bottom).offset(50) // Label의 bottom과 StackView의 top의 거리를 50만큼 떨어지게 설정.
        }
        
    }
    
    
    
    // makeButton 메서드를 생성하여 button의 속성.
    private func makeButton(title: String) -> UIButton {
        
        let button = UIButton() // button 상수 생성.
        
        button.setTitle(title, for: .normal) // 버튼의 제목, title.
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30) // 버튼의 폰트는 bold체, 사이즈는 30.
        button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0) // 버튼의 배경색은 회색.
        button.layer.cornerRadius = 40 // 버튼의 테두리는 40만큼 깎임.
        
        return button // button 리턴 값.
    }
    
    // 똑같은 스택 뷰가 4줄이 필요하기 떄문에 horizontalStackView를 생성하는 메서드를 정의.
    private func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views) // horizontalStackView 상수 생성.
        
        stackView.axis = .horizontal // 수평(가로) 축.
        stackView.backgroundColor = .black // horizontalStackView의 배경색은 검은색.
        stackView.spacing = 10 // 스택 뷰 안에 들어있는 뷰들의 거리 10 설정.
        stackView.distribution = .fillEqually // 분배, 스택 뷰 내부의 사이즈 분배에 관한 설정. fillEqually를 선택하면 뷰들의 사이즈가 동일하게 맞춰진다.
        
        return stackView // stackView 리턴 값.
        
    }
    
}

