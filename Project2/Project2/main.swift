//
//  main.swift
//  Project2
//
//  Created by 이정인 on 1/13/26.
//

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
