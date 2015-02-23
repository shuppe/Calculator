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
        
        if (displayValue != nil) {numberStack.append(displayValue!)
        addToHistory("\(displayValue!)")
        userIsInTheMiddleOfTypingANumber = false
        numberIsDecimal = false
            println("numberStack = \(numberStack)")}
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
    
    @IBAction func backspace() {
        if userIsInTheMiddleOfTypingANumber
        {
            if (countElements(display.text!) == 1)
            {
                display.text! = "0"
                userIsInTheMiddleOfTypingANumber = false
            }
            else
            {
                
                display.text! = dropLast(display.text!)
                
            }
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
        case "±": performOperation {$0 * -1.0}
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
            addToHistory("=")
            enter()

        }
    }
    
    func performOperation (operation: (Double) ->Double)
    {
        if numberStack.count >= 1 {
            displayValue = operation(numberStack.removeLast())
            addToHistory("=")
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
        history.text! = ""
        numberStack.removeAll()
        println("numberStack = \(numberStack)")
        userIsInTheMiddleOfTypingANumber = false
    }
    
    func addToHistory (op: String)
    {
        history.text = history.text! + "\(op)"
    }
    
    var displayValue: Double? {
        get {
            if display.text! == "." { display.text! = "0" }
            let disp = NSNumberFormatter().numberFromString(display.text!)
            switch disp
            {
                case .Some(let value): return value.doubleValue
                case .None:
                    clearDisplay()
                    return nil
            }
            
            
            
        }
        
        set{
            display.text = "\(newValue!)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

