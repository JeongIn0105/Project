# 프로젝트 이름
Swift 기본 개인 과제 제출_이정인

--------------------------------------------------------------------------------

# 프로젝트 소개
## 계산기 앱 만들기
지금까지 배운 Swift 문법을 응용해서 나만의 계산기를 만들어 봅니다!

입문 강의에서 배운 것들을 복습하며 지금까지 Playground에서 로직만 구현했던 계산기에 UI를 더해, 실제 앱으로 완성해봅시다. 

이 과제에서는 간단한 약식 계산기 앱을 개발합니다.
 - 소수점을 고려하지 않은, 정수형 계산만 하며
 - 모든 연산 버튼을 클릭할때마다 계산이 이루어지도록 하지는 않으며
 - 등호 버튼 (=) 을 클릭했을 때만 연산이 이루어지도록 합니다.
 - 수식 문자열이 들어왔을 때 이를 계산해주는 Swift 의 기본 제공 기능을 활용합니다.

--------------------------------------------------------------------------------

# 코드 설명
## LV 1
### 1. UILabel 을 사용해서 수식을 표시할 수 있는 라벨을 띄웁니다.
### 2. 전체 코드
***
// 계산기 앱 만들기
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Level 1. UILabel 사용
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
        label.font = UIFont.boldSystemFont(ofSize: 60) // 폰트는 bold체, 사이즈는 60
        
        view.addSubview(label)
        
        // Label의 제약 조건
        label.snp.makeConstraints {
            $0.height.equalTo(100) // height는 100으로 설정
            $0.leading.trailing.equalToSuperview().offset(-30) // leading, trailing는 뷰로 부터 30 떨어지도록 설정
            $0.top.equalToSuperview().offset(200) // top은 뷰로 부터 200 떨어지도록 설정
        }
    }
    
}
***


### LV 1 알고리즘
- **속성**
    - backgroundColor = .black
    - textColor = .white
    - 우선, 텍스트는 12345 로 고정
    - 텍스트 오른쪽 정렬
    - Font = 시스템 볼드체, 사이즈 60
- **AutoLayout**
    - leading, trailing = superView 로 부터 30 떨어지도록 세팅
    - top = superView 로 부터 200 떨어지도록 세팅
    - height = 100



## LV 2
### 1. UIStackView 을 사용해서 4개의 버튼을 모아 가로 스택뷰 생성. 왼쪽과 같이 구성해보세요.
### 2. 전체 코드 
***
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
***


### LV 2 알고리즘 
<aside>
- **UIButton 속성**
    - font = .boldSystemFont(ofSize: 30)
    - backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    - height = 80
    - width = 80
    - layer.cornerRadius = 40
- **horizontalStackView 속성**
    - axis = .horizontal
    - backgroundColor = .black
    - spacing = 10
    - distribution = .fillEqually
- **horizontalStackView AutoLayout**
    - height = 80
</aside>

#### 힌트: func makeHorizontalStackView(_ views: [UIView]) → UIStackView 와 같은 형태로 horizontalStackView 를 생성하는 메서드를 정의해두면 좋습니다. 똑같은 스택뷰 4줄이 필요.



## LV 3
### 1. UIStackView 을 사용해서 세로 스택 뷰 생성. 왼쪽과 같이 구성해보세요.
### 2. 전체 코드
***
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
        
        
        // Level 3. UIStackView을 사용해서 세로 스택 뷰 생성.
        let buttonTitles = [ // buttonTitles 상수 안에 배열 생성.
            ["7", "8", "9", "+"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "*"],
            ["AC", "0", "=", "/"]
        ]
        
        // horziontalStackView 배열.
        let horziontalStackView = buttonTitles.map { titles in // 고차함수 중에 map을 사용하여 배열의 각 요소를 변환하여 새로운 배열을 생성.
            
            makeHorizontalStackView(titles.map { makeButton(title: $0) })
        }
        
        
        // verticalStackView의 속성.
        let verticalStackView = UIStackView(arrangedSubviews: horziontalStackView)
        verticalStackView.axis = .vertical // 수직(세로) 축.
        verticalStackView.backgroundColor = .black // verticalStackViewd의 배경색은 검은색.
        verticalStackView.spacing = 10 // 스택 뷰 안에 들어있는 뷰들의 거리 10 설정.
        verticalStackView.distribution = .fillEqually // 분배, 스택 뷰 내부의 사이즈 분배에 관한 설정. fillEqually를 선택하면 뷰들의 사이즈가 동일하게 맞춰진다.
        
        view.addSubview(verticalStackView)
        
        // verticalStackView의 제약 조건
        verticalStackView.snp.makeConstraints {
            $0.width.height.equalTo(350) // 가로와 세로의 길이를 350으로 설정.
            $0.top.equalTo(label.snp.bottom).offset(60) // top = label 의 bottom 으로 부터 60 떨어지도록.
            $0.centerX.equalToSuperview() //
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
***


### LV 3. 알고리즘
- **verticalStackView 속성**
    - axis = .vertical
    - backgroundColor = .black
    - spacing = 10
    - distribution = .fillEqually
- **verticalStackView AutoLayout**
    - width = 350
    - top = label 의 bottom 으로 부터 60 떨어지도록 합니다.
    - centerX = superView 와 같도록 합니다.



## LV 4
### 1. 연산 버튼 (+, -, *, /, AC, =) 들은 색상을 orange 로 설정.
### 2. 전체 코드
***
// 계산기 앱 만들기
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Level 1. UILabel 사용
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
        label.font = UIFont.boldSystemFont(ofSize: 60) // 폰트는 bold체, 사이즈는 60
        
        view.addSubview(label)
        
        // Label의 제약 조건
        label.snp.makeConstraints {
            $0.height.equalTo(100) // height는 100으로 설정
            $0.leading.trailing.equalToSuperview().offset(-30) // leading, trailing는 뷰로 부터 30 떨어지도록 설정
            $0.top.equalToSuperview().offset(200) // top은 뷰로 부터 200 떨어지도록 설정
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
                        action: #selector(buttonTapped(_:)), // 버튼 눌렀을 때 실행될 메서드 연결
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
        print(sender.currentTitle ?? "")
    }
    
}
***


### LV 4 알고리즘
#### 개발 효율성을 위한 팁.
#### 버튼을 만드는 func makeButton 이라는 메서드가 있었고 인자로 titleValue: String, action: Selector, backgroundColor: UIColor 를 받을 수 있으면 편합니다.



## LV 5
### 1. 모든 버튼들을 원형으로 만들기.
### 2. 전체 코드
***
// 계산기 앱 만들기
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Level 1. UILabel 사용
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
        label.font = UIFont.boldSystemFont(ofSize: 60) // 폰트는 bold체, 사이즈는 60
        
        view.addSubview(label)
        
        // Label의 제약 조건
        label.snp.makeConstraints {
            $0.height.equalTo(100) // height는 100으로 설정
            $0.leading.trailing.equalToSuperview().offset(-30) // leading, trailing는 뷰로 부터 30 떨어지도록 설정
            $0.top.equalToSuperview().offset(200) // top은 뷰로 부터 200 떨어지도록 설정
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
                        action: #selector(buttonTapped(_:)), // 버튼 눌렀을 때 실행될 메서드 연결
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
        print(sender.currentTitle ?? "")
    }
    
}
***


### LV 5. 알고리즘
#### button.layer.cornerRadius = 40을 작성하면 모든 버튼들이 원형으로 바뀐다.



## LV 6. 
### 1. 버튼을 클릭하면 라벨에 표시되도록 합니다.
### 2. 이제 기본 텍스트는 “12345” 가 아닌 “0” 이 되도록 합니다.
### 3. 기본으로 라벨에 노출되어있던 텍스트 오른쪽에 버튼을 클릭하면 그 버튼의 값이 추가되도록 합니다.
####  - 예를 들어 설명하면
#####    1. 맨처음 기본값 0 
#####    2. 그 다음 1 클릭했음 → 표시되는 값은 01 
#####    3. 그 다음 2 클릭했음 → 표시되는 값은 012 
#####    4. 그 다음 + 클릭했음 → 표시되는 값은 012+
#####    5. 그 다음 3 클릭했음 → 표시되는 값은 012+3
### 4. 하지만 012 라는 값은 이상합니다. 맨 앞자리가 0 인 숫자라면, 0을 지우고 표현하도록 합니다.
#### - 예를 들면, 012 → 12 가 되어야 합니다.
### 5. 전체 코드
***
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
        
    }

}
***


### LV 6. 알고리즘
#### label.text = "0" // Level 6. 이제 기본 텍스트는 "12345"가 아닌 "0"이 되도록 합니다.
#### guard문을 사용해서 조건이 false일 때 코드를 더이상 실행시키지 않고 코드블록을 빠져나가는 조건문. -> 만약 currentTitle이 없다면 return, 있다면 value 상수에 담아서 코드를 계속 실행하게 됩니다.
#### 기본으로 라벨에 노출되어있던 텍스트 오른쪽에 버튼을 클릭하면 그 버튼의 값이 추가되도록 합니다.
#### 012 라는 값이 이상하기 때문에, 맨 앞자리가 0 인 숫자라면, 0을 지우고 표현하도록 합니다.



## LV 7. 
### 1. 초기화 버튼 (AC) 을 구현합니다.
### 2. 전체 코드
***
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
***


### LV 7. 알고리즘
#### AC 버튼을 클릭하면 모든 값을 지우고 “0” 으로 초기화 되도록 구현합니다.



## LV 8.
### 1. 등호 (=) 버튼을 클릭하면 연산이 수행되도록 구현합니다.
#### - 1+2+3 을 입력 후, = 을 클릭하면 결과값인 6 이 출력되도록 해주세요.
#### - 123*456 을 입력 후, = 을 클릭하면 결과값인 56088 이 출력되도록 해주세요.
#### - 연산에 필요한 메서드를 제공해드리겠습니다. 이 메서드를 활용해주세요.
### 2. 전체 코드
***
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
        
        
        // Level 8. 등호(=)버튼을 클릭하면 연산이 수행하도록 구현.
        if value == "=" { // = 버튼을 누를 때, 수식에서 = 제거하고 계산.
            if let text = label.text { // 라벨에 표시된 수식이 존재할 때만 다음 코드를 실행.
                let expression = text.replacingOccurrences(of: "=", with: "") // 수식 문자열에서 = 문자를 제거해서 계산 가능한 형태로 만듬.
                
                if let result = calculate(expression: expression) { // 정리된 수식을 calculate 메서드에 전달해 계산 결과를 얻음.
                    label.text = String(result) // 계산된 결과를 문자열로 변환해서 라벨에 표시.
                }
            }
            return
        }
        
        
    }
    
    
    
    // Level 8. 수식 문자열을 넣으면 계산해주는 calculate 메서드.
    private func calculate(expression: String) -> Int? { // 문자열로 된 수식을 받아서 계산 결과를 Int로 반환하는 함수이고, 실패하면 nil을 반환.
        
        let expression = NSExpression(format: expression) // 전달받은 수식 문자열을 NSExpression 객체로 변환해서 계산 가능한 형태로 만듬.
        
        if let result = expression.expressionValue(with: nil, context: nil) as? Double { // 수식을 실제로 계산하고, 결과를 Double 타입으로 받을 수 있는지 확인.
            
            return Int(result) // 계산 결과(Double)를 Int로 변환해서 반환.
        } else {
            
            return nil
        }
        
    }
    
}
***


### LV 8. 알고리즘
#### 연산에 필요한 메서드를 제공해드리겠습니다. 이 메서드를 활용해주세요.
    
    ```swift
    /// 수식 문자열을 넣으면 계산해주는 메서드.
    ///
    /// 예를 들어 expression 에 "1+2+3" 이 들어오면 6 을 리턴한다.
    /// 잘못된 형식의 수식을 넣으면 앱이 크래시 난다. ex) "1+2++"
    func calculate(expression: String) -> Int? {
            let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    ```
    
    

--------------------------------------------------------------------------------

# 팀 소개
## AI써 말어?
