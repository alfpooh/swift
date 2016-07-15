//
//  ViewController.swift
//  FiksuCalculator
//
//  Created by donghoon bae on 2016. 7. 14..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //displaying digits
    @IBOutlet weak var display: UILabel!
    
    @IBAction func clearCalc(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            let textInTheCurrentDisplay = display.text!
            display.text = String(textInTheCurrentDisplay.characters.dropLast())
            if display.text == "" {display.text="0"}
            
        } else {
        display.text = "0"
        }
    }
    
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit (sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textInTheCurrentDisplay = display.text!
            display.text = textInTheCurrentDisplay + digit
        } else {
            if digit == "." { display.text = "0\(digit)"}
            else {
                display.text = digit}
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
            
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation (sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

