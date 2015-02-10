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

    var userIsInTheMiddleOfTypingANumber = false
    var numberIsDecimal = false
    var numberStack = Array<Double>()
    
    @IBAction func enter()
    {
        
        numberStack.append(displayValue)
        userIsInTheMiddleOfTypingANumber = false
        numberIsDecimal = false
        println("numberStack = \(numberStack)")
    }

    @IBAction func appendDigit(sender: UIButton)
    {

        let digit = sender.currentTitle!
        
        switch digit{
        case "." :
            if !numberIsDecimal
            {
                if (!userIsInTheMiddleOfTypingANumber)
                {
                    clearDisplay()
                }
                numberIsDecimal = true
                display.text! = display.text! + digit
                userIsInTheMiddleOfTypingANumber = true
            }
        default:
            if (digit != "." || display.text!.rangeOfString(".")! != nil) {
                if userIsInTheMiddleOfTypingANumber
                {
                    display.text! = display.text! + digit
                }
                else
                {
                    display.text! = digit
                    userIsInTheMiddleOfTypingANumber = true
                }
            }
        }
        
    }
    
    @IBAction func compute(sender: UIButton)
    {
        let operation = sender.currentTitle!
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
            
            default:break
        }
    }
    
    
    func performOperation (operation: (Double, Double) ->Double)
    {
        var result = 0.0
        if numberStack.count >= 2 {
            displayValue = operation(numberStack.removeLast(), numberStack.removeLast())
            enter()
        }
    }
    
    func performOperation (operation: (Double) ->Double)
    {
        var result = 0.0
        if numberStack.count >= 1 {
            displayValue = operation(numberStack.removeLast())
            enter()
        }
    }
    
    func addDecimalPoint() {}
    
    @IBAction func clearDisplay() {
        display.text! = "0"
        userIsInTheMiddleOfTypingANumber = false
    }
    
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
        
}

