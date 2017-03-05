import Foundation

// Exam: Basic Summation recursive function, Note: must be coded
// outside of the class

func summation(n:Double, m:Double)->Double {
    if n>m {
        return 0
    } else {
        return n + summation(n: n+1, m: m)
    }
}

class Brain {
    private var currentResult = 0.0
    var result:Double {
        get {
            return self.currentResult
        }
    }
    
    func setCurrentResult(aResult:Double) {
        self.currentResult = aResult
    }
    
    private enum OperationTypes {
        case Constant(Double)
        case UnaryOperator((Double)->Double)
        case BinaryOperator((Double, Double)->Double)
        case Equals
    }
    
    private let operations:Dictionary<String,OperationTypes> = [
        "π" : .Constant(M_PI),
        "e" : .Constant(M_E),
        "√" : .UnaryOperator(sqrt),
        "±" : .UnaryOperator({$0 != 0 ? -$0 : 0.0}),
        "+" : .BinaryOperator({$0+$1}),
        "−" : .BinaryOperator({$0-$1}),
        "×" : .BinaryOperator({$0*$1}),
        "÷" : .BinaryOperator({$0/$1}),
        // Exam: The Summation method is added as a UnaryOperator
        "∑" : .BinaryOperator(summation),
        "=" : .Equals
    ]
    
    func performOperation(symbol:String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let theConstant):
                self.currentResult = theConstant
            case .UnaryOperator(let theUnaryFunction):
                self.currentResult = theUnaryFunction(self.currentResult)
            case .BinaryOperator(let theBinaryOperator):
                self.pendingOperation = PendingBinaryOperationInfo(binaryOperator: theBinaryOperator,
                    firstOperand: self.currentResult)
            case .Equals:
                if let _ = pendingOperation {
                    self.currentResult = pendingOperation.binaryOperator(pendingOperation.firstOperand, self.currentResult)
                    pendingOperation = nil
                }
            }
        }
    }
    
    private var pendingOperation:PendingBinaryOperationInfo!
    
    struct PendingBinaryOperationInfo {
        var binaryOperator:(Double, Double)->Double
        var firstOperand:Double
    }
}
