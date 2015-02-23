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
        case BinaryOpration(String, (Double, Double) ->Double)
    }
    
    var OpStack = [Op]()
    
}