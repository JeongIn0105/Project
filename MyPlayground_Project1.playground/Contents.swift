//import UIKit

//var greeting = "Hello, playground"

// AbstractOperation 추상화 클래스
class AbstractOperation {
    func operate(_ num1: Int, _ nun2: Int) -> Double {
        return -1
    }
}

// AddOperation(더하기) 클래스
class AddOperation: AbstractOperation {
    override func operate(_ num1: Int, _ num2: Int) -> Double {
        Double(num1 + num2)
    }
}

// SubstractOperation(빼기) 클래스
class SubstractOperation: AbstractOperation {
    override func operate(_ num1: Int, _ num2: Int) -> Double {
        Double(num1 - num2)
    }
}

// MultiplyOperation(곱하기) 클래스
class MultiplyOperation: AbstractOperation {
    override func operate(_ num1: Int, _ num2: Int) -> Double {
        Double(num1 * num2)
    }
}

// DivideOperation(나누기) 클래스
class DivideOperation: AbstractOperation {
    override func operate(_ num1: Int, _ num2: Int) -> Double {
        return Double(num1) / Double(num2)
    }
}

class Calculator {
    var operation: AbstractOperation

    init(operation: AbstractOperation) {
        self.operation = operation
    }

    func operate(_ num1: Int, _ num2: Int) -> Double {
        operation.operate(num1, num2)
    }
}

enum OperatorType {
    case add
    case substract
    case multiply
    case divide
}

let addOperation = AddOperation()
let substractOperation = SubstractOperation()
let multiplyOperation = MultiplyOperation()
let divideOperation = DivideOperation()
    
let calculator = Calculator(operation: addOperation) // 인스턴스 생성하여 변수에 할당


// Todo : calculator 변수를 활용하여 사칙연산을 진행

print("*** Swift로 계산기 만들기 ***")
 
 // 1. 더하기 출력
calculator.operation = addOperation
print("더하기 결과 :", calculator.operate(1, 2))
 
 // 2. 빼기 출력
calculator.operation = substractOperation
print("빼기 결과 :", calculator.operate(3, 1))
 
 // 3. 곱하기 출력
calculator.operation = multiplyOperation
print("곱하기 결과 :", calculator.operate(3, 5))
 
 // 4. 나누기 출력
calculator.operation = divideOperation
print("나누기 결과 :", calculator.operate(1, 3))
 
 /*
  // 5. 나머지 출력
  if let result = calculator.remainder() {
  print("나머지 결과 :", result) // 2
  }
  */

