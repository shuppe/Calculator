//
//  ViewController.swift
//  Calculator
//
//  Created by Sylvain on 2015-02-07.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var numberIsDecimal = false
    var numberStack = Array<Double>()
    
    let constants = ["π": M_PI]
    
    @IBAction func enter()
    {
        
        numberStack.append(displayValue)
        addToHistory("\(displayValue)")
        userIsInTheMiddleOfTypingANumber = false
        numberIsDecimal = false
        println("numberStack = \(numberStack)")
    }
    
    @IBAction func appendDigit(sender: UIButton)
    {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber
        {
            display.text! = display.text! + (digit == "." ? (display.text!.rangeOfString(digit) == nil ? digit : "") : digit)
        }
        else
        {
            display.text! = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
    }
    
    @IBAction func compute(sender: UIButton)
    {
        let operation = sender.currentTitle!
        addToHistory(operation)
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation
        {
        case "×": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$0 + $1}
        case "−": performOperation {$1 - $0}
        case "√": performOperation {sqrt($0)}
        case "cos": performOperation {cos($0)}
        case "sin": performOperation {sin($0)}
        case "π": performOperation(operation)
            
        default:break
        }
    }
    
    
    func performOperation (operation: (Double, Double) ->Double)
    {
        if numberStack.count >= 2 {
            displayValue = operation(numberStack.removeLast(), numberStack.removeLast())
            enter()
        }
    }
    
    func performOperation (operation: (Double) ->Double)
    {
        if numberStack.count >= 1 {
            displayValue = operation(numberStack.removeLast())
            enter()
        }
    }
    
    func performOperation (op: String)
    {
            displayValue = constants[op]!
            enter()
        
    }
    
    @IBAction func clearDisplay() {
        display.text! = "0"
        numberStack.removeAll()
        userIsInTheMiddleOfTypingANumber = false
        println("numberStack = \(numberStack)")
    }
    
    func addToHistory (op: String)
    {
            history.text = history.text! + ", \(op)"
    }

    var displayValue: Double {
        get {
            if display.text! == "." { display.text! = "0" }
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

