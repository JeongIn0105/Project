//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 이정인 on 1/23/26.
//

// 계산기 앱 만들기.
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
        label.text = "0" // Level 6. 이제 기본 텍스트는 "12345"가 아닌 "0"이 되도록 합니다.
        label.textColor = .white // 텍스트의 색상은 하얀색.
        label.textAlignment = .right // 텍스트의 정렬은 오른쪽 정렬.
        label.font = UIFont.boldSystemFont(ofSize: 60) // 폰트는 bold체, 사이즈는 60.
        
        view.addSubview(label)
        
        // Label의 제약 조건.
        label.snp.makeConstraints {
            $0.height.equalTo(100) // height는 100으로 설정.
            $0.leading.trailing.equalToSuperview().inset(30) // leading, trailing는 뷰로 부터 30 떨어지도록 설정.
            $0.top.equalToSuperview().offset(200) // top은 뷰로 부터 200 떨어지도록 설정.
        }
        
        
        // Level 3. UIStackView을 사용해서 세로 스택 뷰 생성.
        let buttonTitles = [ // buttonTitles 상수 안에 배열 생성.
            ["7", "8", "9", "+"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "*"],
            ["AC", "0", "=", "/"]
        ]
        
        // Level 4. 연산 버튼(+, -, *, /, AC, =)들은 색상을 orange로 설정.
        let orangeOperator: Set<String> = ["+", "-", "*", "/", "AC", "="] // 순서가 없고 중복을 허용하지 않기 떄문에 Set을 사용.
        
        let horizontalStackView = buttonTitles.map { operators in // 고차함수 중에 map을 사용하여 배열의 각 요소를 변환하여 새로운 배열을 생성.
            
            makeHorizontalStackView( // 만들어진 버튼 배열들을 가로 스택 뷰로 정렬.
                operators.map {title in // 연산자 문자열 하나씩 꺼내서 UIButton으로 생성.
                    makeButton(
                        titleValue: title,
                        action: #selector(buttonTapped(_:)), // 버튼 눌렀을 때 실행될 메서드 연결.
                        backgroundColor: orangeOperator.contains(title) ? .orange : UIColor( // 연산자면 오렌지색, 아니면 회색.
                            red: 58/255,
                            green: 58/255,
                            blue: 58/255,
                            alpha: 1.0
                                                                                           )
                    )
                }
            )
        }
        
        
        // verticalStackView의 속성.
        let verticalStackView = UIStackView(arrangedSubviews: horizontalStackView) // 가로 스택 뷰들을 세로로 정렬하기 위해, horizontalStackView를 내부 요소로 갖는 세로 UIStackView를 생성.
        
        verticalStackView.axis = .vertical // 수직(세로) 축.
        verticalStackView.backgroundColor = .black // verticalStackViewd의 배경색은 검은색.
        verticalStackView.spacing = 10 // 스택 뷰 안에 들어있는 뷰들의 거리 10 설정.
        verticalStackView.distribution = .fillEqually // 분배, 스택 뷰 내부의 사이즈 분배에 관한 설정. fillEqually를 선택하면 뷰들의 사이즈가 동일하게 맞춰진다.
        
        view.addSubview(verticalStackView) // 생성한 스택뷰를 화면에 보이도록 뷰 계층에 추가.
        
        // verticalStackView의 제약 조건.
        verticalStackView.snp.makeConstraints {
            $0.width.height.equalTo(350) // StackView의 높이를 350만큼 설정.
            $0.centerX.equalToSuperview() // centerX = superView 와 같도록.
            $0.top.equalTo(label.snp.bottom).offset(60) // top = label 의 bottom 으로 부터 60 떨어지도록.
        }
    }
    
    
    // Level 4. makeButton 메서드를 생성하여 button의 속성.
    private func makeButton(titleValue: String, action: Selector, backgroundColor: UIColor) -> UIButton {
        
        let button = UIButton() // button 상수 생성.
        
        button.setTitle(titleValue, for: .normal) // 버튼의 제목, title.
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30) // 버튼의 폰트는 bold체, 사이즈는 30.
        button.backgroundColor = backgroundColor // 버튼의 배경색은.
        button.layer.cornerRadius = 40 // 버튼의 테두리는 40만큼 깎임. -> Level 5. 모든 버튼들을 원형으로 만들기.
        button.addTarget(self, action: action, for: .touchUpInside) // 버튼을 눌렀을 때(.touchUpInside) 지정한 메서드(action)가 실행되도록 이벤트를 연결.
        
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
    
    // Button의 Action 생성.
    @objc
    private func buttonTapped(_ sender: UIButton) {
        
        // Level 6. 버튼을 클릭하면 라벨에 표시되도록 합니다.
        guard let value = sender.currentTitle else { return } // guard문은 조건이 false일 때 코드를 더이상 실행시키지 않고 코드블록을 빠져나가는 조건문. -> 만약 currentTitle이 없다면 return, 있다면 value 상수에 담아서 코드를 계속 실행.
        
        // 기본으로 라벨에 노출되어있던 텍스트 오른쪽에 버튼을 클릭하면 그 버튼의 값이 추가되도록 합니다.
        if label.text == "0" { // 맨 처음 기본값이 0.
            label.text = value
        } else {
            label.text? += value // 선택적 타입 'String?'의 값은 'String' 타입의 값으로 언래핑되어야 합니다.
        }
        
        // 하지만 012 라는 값은 이상합니다. 맨 앞자리가 0 인 숫자라면, 0을 지우고 표현하도록 합니다.
        if label.text?.first == "0" {
            label.text = String(label.text!.split(separator: "").dropLast().joined()) // 라벨에 있는 문자열에서 맨 마지막 글자 하나를 지움.
        }
        

        // Level 7. 초기화 버튼 (AC)을 구현합니다.
        if value == "AC" {
            label.text = "0" // AC 버튼을 클릭하면 모든 값을 지우고 "0"으로 초기화.
            return // return은 함수를 즉시 종료.
        }
        
    }

}



