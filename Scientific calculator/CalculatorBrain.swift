//
//  CalculatorBrain.swift
//  Scientific calculator
//
//  Created by 丁建新 on 16/7/20.
//  Copyright © 2016年 丁建新. All rights reserved.
//

import Foundation
class CalculatorBrain
{
    private var accumulator=0.0
    func setOperand(operand: Double){
        accumulator=operand
    }
    
    private var operations: Dictionary<String,Operation>=
        [
            "e":Operation.Constant(M_E),
            "π":Operation.Constant(M_PI),
            "×":Operation.BinaryOperation({$0 * $1}),
            "÷":Operation.BinaryOperation({$0 / $1}),
            "+":Operation.BinaryOperation({$0 + $1}),
            "−":Operation.BinaryOperation({$0 - $1}),
            "%":Operation.UnaryOperation ({$0 / 100} ),
            "1/x":Operation.UnaryOperation ({1/$0} ),
            "±":Operation.UnaryOperation({ -$0  }),
            "√x":Operation.UnaryOperation(sqrt),
            "∛x":Operation.UnaryOperation(cbrt),
            "e^x":Operation.UnaryOperation(exp),
            "10^x":Operation.UnaryOperation(__exp10),
            "log₁₀":Operation.UnaryOperation(log10),
            "ln":Operation.UnaryOperation(log),
            "x^y":Operation.BinaryOperation(pow),
            "cos":Operation.UnaryOperation(cos),
            "sin":Operation.UnaryOperation(sin),
            "tan":Operation.UnaryOperation(tan),
            "cosh":Operation.UnaryOperation(cosh),
            "sinh":Operation.UnaryOperation(sinh),
            "tanh":Operation.UnaryOperation(tanh),
            "| |":Operation.UnaryOperation(fabs),
            "=":Operation.Equals
    ]
    
    
    
    
    private enum Operation {
        case Constant(Double)
        case BinaryOperation((Double,Double)-> Double)
        case UnaryOperation((Double)-> Double)
        case Equals
        
        
    }
    func performOperation(symbol:String){
        if  let operation=operations[symbol]
        {
            switch operation{
            case.Constant(let value):
                accumulator=value
            case.BinaryOperation(let function):
                executePendingBinaryOperation()
                pending=PendingBinaryOperationInfo(binaryFunction: function,firstOperand: accumulator)
            case.UnaryOperation(let function ):
                accumulator=function(accumulator)
            case.Equals:
                executePendingBinaryOperation()
            }
        }
        
    }
    private func executePendingBinaryOperation()
    {
        if pending != nil
            
        {
            accumulator=pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending=nil
        }
    }
    
    private var pending:PendingBinaryOperationInfo?
    private struct PendingBinaryOperationInfo{
        var binaryFunction:(Double,Double)->Double
        var firstOperand:Double
        
    }
    var clean:Double  {
        get {
            return 0 }
    }
    
    
    var result:Double{
        get{
            
            return accumulator }
        
    }
}
