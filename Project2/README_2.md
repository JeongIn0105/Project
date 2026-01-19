# 프로젝트 이름
Swift 기본 개인 과제 제출_이정인

--------------------------------------------------------------------------------

# 프로젝트 소개
## Swift로 숫자 야구 게임 만들기
지금까지 배운 Swift 문법을 응용해서 나만의 계산기를 만들어 봅니다!

숫자 야구 게임은 두 명이 즐길 수 있는 추리 게임으로, 상대방이 설정한 3자리의 숫자를 맞추는 것이 목표!
각 자리의 숫자와 위치가 모두 맞으면 "스트라이크", 숫자만 맞고 위치가 다르면 "볼"로 판정됩니다!
예를 들어, 상대방의 숫자가 123일 때 132를 추리하면 1스트라이크 2볼입니다!
이러한 힌트를 활용하여 상대방의 숫자를 추리해 나가는 게임입니다.

--------------------------------------------------------------------------------

# 코드 설명
## LV 1
### 1. 1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다.
### 2. 정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)
### 3. 코드
// Swift로 숫자 야구 게임 만들기
import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class BaseballGame { // 클래스로 선택!
    
    func start() {
        let answer = makeAnswer() // 정답을 만드는 함수
        print("*** 숫자 야구 게임 시작!!! ***")
        print("결과 : \(answer)")
        
    }
    
    func makeAnswer() -> [Int] {
        
        // 함수 내부를 구현하기
        var number: Set<Int> = []
        
        // 1에서 9까지의 서로 다른 임의의수 3자리 구현
        while number.count < 3 {
            var randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            
            if number.isEmpty { // 숫자가 비어있다면
                randomNumber = Int.random(in: 1...9)
            }
            
            number.insert(randomNumber)
        }
        return Array(number)
    }
   
}

// LV 1 알고리즘
// makeAnswer() : 정답을 만드는 함수 
// 변수 number 생성하고, Set으로 구현(Set을 선택한 이유는 순서가 없고 중복을 허용하지 않기 때문에)
// 범위 : 1에서 9까지의 서로 다른 임의의 수 3자리 -> 1...9
// 배열 [ ] 으로 서로 다른 임의의 수 3자리 결과 출력, 예: [1, 3, 7]
// while 반복문을 사용하여 서로 다른 임의의 수 3자리 랜덤으로 출력하게 만들기

## LV 2
### 1. 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다.
#### - 힌트 : 야구용어인 볼과 스트라이크 입니다.
#### - 같은 자리에 같은 숫자가 있으면 스트라이크, 다른 자리에 숫자가 있는 경우 볼입니다.
##### 예시) 정답 : 456 인 경우
###### - 435를 입력한 경우 : 1스트라이크 1볼
###### - 357를 입력한 경우 : 1스트라이크
###### - 678를 입력한 경우 : 1볼
###### - 123를 입력한 경우 : Nothing
##### 만약 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요.
#### - 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다.
// Swift로 숫자 야구 게임 만들기
import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class BaseballGame {
    func start() {
        
        while true {
            let answer = makeAnswer() // 정답을 만드는 함수
            print("*** 숫자 야구 게임 시작 ***")
         
                while true {
                    
                    print("숫자를 입력하세요!")
                    
                    // LV 2. 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다.
                    // 1. 유저에게 입력값을 받음
                    guard let input = readLine() else {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue // 반복문 안에서 현재 반복을 건너뛰고 다음 반복으로 넘어가세요~~~
                    }
                    
                    // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
                    guard let _ = Int(input) else {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
                    // number 상수에 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환
                    let number = input.map { String($0) } // map을 활용해 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환한다.
                    
                    // 세 자리가 아니면
                    if number.count != 3 {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    1
                    // 숫자 0 포함 여부가 되었는지
                    if number.contains("0") { // LV 3 : number.contains("0") -> number.first == "0" 수정
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    // 중복된 숫자가 있는지
                    if Set(number).count != 3 {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    let numbers = number.compactMap { Int($0) } // compactMap을 활용하여 중복 숫자 안 나오게 만듬
                    
                    // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
                    // 스트라이크, 볼 변수 생성
                    var strike = 0 // 스트라이크
                    var ball = 0 // 볼
                    
                    // 스트라이크, 볼 판정 여부
                    for i in 0..<3 {
                        if numbers[i] == answer[i] { // 같은 자리에 같은 숫자가 있으면
                            strike += 1
                        } else if answer.contains(numbers[i]) { // 다른 자리에 같은 숫자가 있으면
                            ball += 1
                        }
                    }
                    
                    // 스트라이크, 볼 출력
                    if strike == 0 && ball == 0 { // 스트라이크와 볼이 둘 다 0개이면
                        print("Nothing")
                    } else if strike == 0 { // 스트라이크가 0개이면
                        print("\(ball)볼")
                    } else if ball == 0 && strike != 3 { // 볼이 0개이고 스트라이크가 3개 이하라면
                        print("\(strike)스트라이크")
                    } else if strike == 3 { // 스트라이크가 3개이면
                        print("정답입니다!")
                    } else {
                        print("\(strike)스트라이크 \(ball)볼")
                    }
                }
          
            }
  
        }
    }
    
    func makeAnswer() -> [Int] { // Int 타입에 배열로 넣어줌
        
        // 함수 내부를 구현하기
        var number: Set<Int> = [] // 서로 다른 임의의 수 3자리이기 때문에 순서가 없고 중복된 값을 허용하지 않기 때문에 Set을 사용
        
        // LV 1.
        // 1에서 9까지의 서로 다른 임의의수 3자리 구현
        while number.count < 3 {
            var randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            
            if number.isEmpty { // 숫자가 비어있다면
                randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            }
            
            number.insert(randomNumber)
        }
        return Array(number)
    }


// LV 2 알고리즘 
// guard문은 조건이 틀린 경우는 모두 버리고, 우리가 원하는 조건만 통과시키겠다는 기능으로 사용된다.
// if문과의 차이점으로 보면 if문은 '~면 ~해라' 의 실행 구문이지만, guard는 '~아니면 끝내라' 라는 의미이기 때문이다.
// 따라서 guard문은 '빠른 종료'의 핵심이라고 한다. -> guard 문 사용
// 
// 1. 유저에게 3자리 수를 입력하기 위해 readLine() 함수를 사용하여 입력값을 받음
// 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기위해 guard let _ = Int(input) else { } 사용함.
// 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기위해 
// 먼저, number 상수에 umber 상수에 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환을 해주기.
// let number = input.map { String($0) }을 작성하였습니다.
// 그 다음에, 세 자리가 아니면 if number.count != 3 { }을 사용하고,
// 숫자 0이 포함되었으면 if number.contains("0") { }을 사용하고,
// 특정 숫자가 두 번 사용되었는지 if Set(number).count != 3 { }을 사용하고 let numbers = number.compactMap { Int($0) }을 
// 사용하여 중복 숫자가 안 나오게 구현했습니다.
//
// 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
// 4-1. 스트라이크와 변수에 초기값을 줘서 할당하기
// 4-2. 스트라이크, 볼을 판정하여 조건문을 사용해 같은 자리에 같은 자리가 있으면 스트라이크 +1 더하고, 다른 자리에 같은 숫자가 있으면 볼 +1 더하기.
// 4-3. 조건문을 사용해 스트라이크, 볼 출력하고 스트라이크와 볼이 둘 다 0이면 Nothing을 출력하고 스트라이크가 3개이면 정답입니다! 출력하기.



## LV 3
### 1. 정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자로 바꿔주세요.
#### 맨 앞자리에 0이 오는 것은 불가능합니다.
##### - 092 : 불가능
##### - 870 : 가능
##### - 300 : 불가능

// Swift로 숫자 야구 게임 만들기
import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class BaseballGame {
    func start() {
        let answer = makeAnswer() // 정답을 만드는 함수
        print("*** 숫자 야구 게임 시작 ***")
        
        while true {
            
            print("숫자를 입력하세요")
            
            // LV 2. 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다.
            // 1. 유저에게 입력값을 받음
            guard let input = readLine() else {
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue // 반복문 안에서 현재 반복을 건너뛰고 다음 반복으로 넘어가세요~~~
            }
            
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            guard let _ = Int(input) else {
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue
            }
            
            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            // number 상수에 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환
            let number = input.map { String($0) } // map을 활용해 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환한다.
            
            // 세 자리가 아니면
            if number.count != 3 {
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue
            }
            
            // 숫자 0 포함 여부가 되었는지
            if number.first == "0" { // LV 3 : number.contains("0") -> number.first == "0" 수정
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue
            }
            
            // 중복된 숫자가 있는지
            if Set(number).count != 3 {
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue
            }
            
            let numbers = number.compactMap { Int($0) } // compactMap을 활용하여 중복 숫자 안 나오게 만듬
            
            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            // 스트라이크, 볼 변수 생성
            var strike = 0 // 스트라이크
            var ball = 0 // 볼
            
            // 스트라이크, 볼 판정 여부
            for i in 0..<3 {
                if numbers[i] == answer[i] { // 같은 자리에 같은 숫자가 있으면
                    strike += 1
                } else if answer.contains(numbers[i]) { // 다른 자리에 같은 숫자가 있으면
                    ball += 1
                }
            }
            
            // 스트라이크, 볼 출력
            if strike == 0 && ball == 0 { // 스트라이크와 볼 둘 다 0개이면
                print("Nothing")
            } else if strike == 0 { // 스트라이크가 0개이면
                print("\(ball)볼")
            } else if ball == 0 && strike != 3 { // 볼이 0개이고 스트라이크가 3개 이하라면
                print("\(strike)스트라이크")
            } else if strike == 3 { // 스트라이크가 3개이면
                print("정답입니다!")
            } else {
                print("\(strike)스트라이크 \(ball)볼")
            }
        }
    }
    
    func makeAnswer() -> [Int] { // Int 타입에 배열로 넣어줌
        
        // 함수 내부를 구현하기
        var number: Set<Int> = [] // 서로 다른 임의의 수 3자리이기 때문에 순서가 없고 중복된 값을 허용하지 않기 때문에 Set을 사용
        
        /* LV 1. 1에서 9까지의 서로 다른 임의의 3개를 정하고 맞추는 게임입니다.
        // 1에서 9까지의 서로 다른 임의의수 3자리 구현
        while number.count < 3 {
            // 정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)
            var randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            
            if number.isEmpty { // 숫자가 비어있다면
                randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            }
            
            number.insert(randomNumber)
        }
        */
        
        // LV 3. 정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자를 바꿔주세요.
        while number.count < 3 {
            
            // 맨 앞자리에 0이 오는 것은 불가능하다.
            if number.count == 0 { // 앞에 자리 숫자가 0이면
                let randomNumber = Int.random(in: 1...9) // 1부터 9까지 숫자 랜덤
                number.insert(randomNumber)
            } else {
                let randomNumber = Int.random(in: 0...9) // 0부터 9까지 숫자 랜덤
                number.insert(randomNumber)
            }
        }
        return Array(number)
    }
}


// LV 3. 알고리즘
// 1. LV 1에서 구현한 코드를 수정하기
// 2. 조건문을 사용하여 맨 앞자리에 0이 오면 1에서 9까지의 서로 다른 임의의 수 3자리 출력하게 하고, 그게 아니면 0에서 9까지의 서로 다른 임의의 수 3자리 출력하기
// 3. LV 2에서 했던 숫자 0이 포함 되었으면 코드 부분에서 if number.first == "0"으로 수정하기



## LV 4
### 1. 프로그램을 시작할 떄 안내문구를 보여주세요
#### 예시
#### 환영합니다! 원하시는 번호를 입력해주세요
#### 1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기

// Swift로 숫자 야구 게임 만들기
import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기


// BaseballGame.swift 파일 생성
class BaseballGame {
    
    func start() {
        
        while true {
            
            // LV 4. 안내 문구 출력
            print("""
                환영합니다! 원하시는 번호를 입력해주세요
                1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
                """)
                  
            // 2. 유저의 입력값을 받음
            guard let input = readLine(), let menu = Int(input) else {
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
                continue
            }

            // 3. 입력값에 따라 처리(switch - case 활용해보기)
            switch menu {
            // 1. 게임 시작하기
            case 1:
                    gameStart() // 1을 입력한 케이스 작성
            // 2, 게임 기록 보기
            case 2:
                    gameRecord() // 2을 입력한 케이스 작성
            // 3. 종료하기
            case 3:
                    print("숫자 야구 게임을 종료합니다.") // 3을 입력한 케이스 작성
            default:
                print("입력이 잘못되었습니다. 다시 입력해주세요!")
            }
            
            // 1. 게임 시작하기
            func gameStart() {
                
                let answer = makeAnswer() // 정답을 만드는 함수
                print("*** 숫자 야구 게임 시작 ***")
                
                while true {
                    
                    print("숫자를 입력하세요!")
                    
                    // LV 2. 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다.
                    // 1. 유저에게 입력값을 받음
                    guard let input = readLine() else {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue // 반복문 안에서 현재 반복을 건너뛰고 다음 반복으로 넘어가세요~~~
                    }
                    
                    // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
                    guard let _ = Int(input) else {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
                    // number 상수에 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환
                    let number = input.map { String($0) } // map을 활용해 각 요소를 변형하는 작업을 반복하며, 변형된 값을 새로운 배열로 반환한다.
                    
                    // 세 자리가 아니면
                    if number.count != 3 {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    // 숫자 0 포함 여부가 되었는지
                    if number.first == "0" { // LV 3 : number.contains("0") -> number.first == "0" 수정
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    // 중복된 숫자가 있는지
                    if Set(number).count != 3 {
                        print("입력이 잘못되었습니다. 다시 입력해주세요!")
                        continue
                    }
                    
                    let numbers = number.compactMap { Int($0) } // compactMap을 활용하여 중복 숫자 안 나오게 만듬
                    
                    // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
                    // 스트라이크, 볼 변수 생성
                    var strike = 0 // 스트라이크
                    var ball = 0 // 볼
                    
                    // 스트라이크, 볼 판정 여부
                    for i in 0..<3 {
                        if numbers[i] == answer[i] { // 같은 자리에 같은 숫자가 있으면
                            strike += 1
                        } else if answer.contains(numbers[i]) { // 다른 자리에 같은 숫자가 있으면
                            ball += 1
                        }
                    }
                    
                    // 스트라이크, 볼 출력
                    if strike == 0 && ball == 0 { // 스트라이크와 볼이 둘 다 0개이면
                        print("Nothing")
                    } else if strike == 0 { // 스트라이크가 0개이면
                        print("\(ball)볼")
                    } else if ball == 0 && strike != 3 { // 볼이 0개이고 스트라이크가 3개 이하라면
                        print("\(strike)스트라이크")
                    } else if strike == 3 { // 스트라이크가 3개이면
                        print("정답입니다!")
                    } else {
                        print("\(strike)스트라이크 \(ball)볼")
                    }
                }
          
            }
            
            // LV 5. 게임 기록 보기
            func gameRecord() {
                
            }
  
        }
    }
    
    func makeAnswer() -> [Int] { // Int 타입에 배열로 넣어줌
        
        // 함수 내부를 구현하기
        var number: Set<Int> = [] // 서로 다른 임의의 수 3자리이기 때문에 순서가 없고 중복된 값을 허용하지 않기 때문에 Set을 사용
        
        /* LV 1.
        // 1에서 9까지의 서로 다른 임의의수 3자리 구현
        while number.count < 3 {
            var randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            
            if number.isEmpty { // 숫자가 비어있다면
                randomNumber = Int.random(in: 1...9) // 랜덤 숫자 1~9까지
            }
            
            number.insert(randomNumber)
        }
        */
        
        // LV 3. 정답이 되는 숫자를 0에서 9까지의 서로 다른 3자리의 숫자를 바꿔주세요.
        while number.count < 3 {
            
            // 맨 앞자리에 0이 오는 것은 불가능하다.
            if number.count == 0 { // 앞에 자리 숫자가 0이면
                let randomNumber = Int.random(in: 1...9) // 1부터 9까지 숫자 랜덤
                number.insert(randomNumber)
            } else {
                let randomNumber = Int.random(in: 0...9) // 0부터 9까지 숫자 랜덤
                number.insert(randomNumber)
            }
        }
        return Array(number)
    }
}

// LV 4 알고리즘
// 1. 안내 문구 출력하기
// print("""
//  환영합니다! 원하시는 번호를 입력해주세요
// 1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기 
// """
//
// 2. 유저의 입력값을 받음.
// guard let input = readLine(), let menu = Int(input) else { }을 생성함
//
// 3. 입력값에 따라 처리(switch - case 활용해보기)
// case 1에 게임 시작하는 함수 gameStart() 생성, case 2에 게임 기록 보는 함수 gameRecord() 생성, 
// case 3에 숫자 야구 게임 죵료합니다를 출력하기
//
// 4. 게임 시작하는 함수 func gameStart() 만들고, 여기에다가 이전에 작성한 코드들 복사하기



## LV 5
### 1. 2번 게임 기록 보기의 경우 완료한 게임들에 대해 시도 횟수를 보여줍니다.
#### 예시
#### < 게임 기록 보기>
#### 1번쨰 게임 : 시도 횟수 - 14
#### 2번째 게임 : 시도 횟수 - 9
#### 3번째 게임 : 시도 횟수 - 12



--------------------------------------------------------------------------------

# 팀 소개
## 언제 따라감?
