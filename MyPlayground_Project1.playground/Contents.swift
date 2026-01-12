//import UIKit

//var greeting = "Hello, playground"

// AddOperation(더하기) 클래스
class AddOperation {
    func caculate(_ num1: Int, _ num2: Int) -> Int {
        return num1 + num2
    }
}

// SubstractOperation(빼기) 클래스
class SubstractOperation {
    func caculate(_ num1: Int, _ num2: Int) -> Int {
        return num1 - num2
    }
}

// MultiplyOperation(곱하기) 클래스
class MultiplyOperation {
    func caculate(_ num1: Int, _ num2: Int) -> Int {
        return num1 * num2
    }
}

// DivideOperation(나누기) 클래스
class DivideOperation {
    func caculate(_ num1: Int, _ num2: Int) -> Int {
        return num1 / num2
    }
}

class Calculator {
    
    // Todo : 내부 구현하기
    // Calculator 클래스와 관계 맺기
    private let addOperation = AddOperation()
    private let substractOperation = SubstractOperation()
    private let multiplyOperation = MultiplyOperation()
    private let divideOperation = DivideOperation()
    
    var num1: Int
    var num2: Int
    
    init(num1: Int, num2: Int) {
        self.num1 = num1
        self.num2 = num2
    }
    
    // 더하기 함수
    func add() -> Int {
        return num1 + num2
    }
    
    // 빼기 함수
    func substract() -> Int {
        return num1 - num2
    }
    
    // 곱하기 함수
    func multiply() -> Int {
        return num1 * num2
    }
    
    // 나누기 함수
    func divide() -> Int? {
        if num2 == 0 {
            return nil
        } else {
            return num1 / num2
        }
    }
    
    // 나머지 함수
    func remainder() -> Int? {
        if num2 == 0 {
            return nil
        } else {
            return num1 % num2
        }
    }
    
}
    
let calculator = Calculator(num1: 23, num2: 7) // 인스턴스 생성하여 변수에 할당


// Todo : calculator 변수를 활용하여 사칙연산을 진행
print("*** Swift로 계산기 만들기 ***")
print("첫 번째 숫자 : ", calculator.num1)
print("두 번째 숫자 : ", calculator.num2)

print("\nㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ\n")

// 1. 더하기 출력
print("더하기 결과 :", calculator.add()) // 30

// 2. 빼기 출력
print("빼기 결과 :", calculator.substract()) // 16

// 3. 곱하기 출력
print("곱하기 결과 :", calculator.multiply()) // 161

// 4. 나누기 출력
 if let result = calculator.divide() {
     print("나누기 결과 :", result) // 3
 }
 
 // 5. 나머지 출력
 if let result = calculator.remainder() {
     print("나머지 결과 :", result) // 2
 }
