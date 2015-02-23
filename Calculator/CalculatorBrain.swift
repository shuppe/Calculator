//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Sylvain on 2015-02-10.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) ->Double)
    }
    
    var OpStack = [Op]()
    
    var knownOps = [String:Op]()
    
    init() {

        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
//        knownOps["±": performOperation {$0 * -1.0}
//        knownOps["cos": performOperation {cos($0)}
//        knownOps["sin": performOperation {sin($0)}
        
//        knownOps["π": performOperation(operation)

    }
    
    func pushOperand(operand: Double) {
        OpStack.append(Op.Operand(operand))
    }
 
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            OpStack.append(operation)
        }
    }
}