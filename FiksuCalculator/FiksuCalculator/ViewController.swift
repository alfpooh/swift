//
//  ViewController.swift
//  FiksuCalculator
//
//  Created by donghoon bae on 2016. 7. 14..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var isBasicShowing = true
    let synth = AVSpeechSynthesizer()
    var buttonclickplayer: AVAudioPlayer!
    var resultplayer: AVAudioPlayer!
    var swipingplayer: AVAudioPlayer!
    var sayCount = AVSpeechUtterance(string: "")
    
    
    @IBOutlet weak var BasicPad: UIView!
    @IBOutlet weak var FunctionPad: UIView!
    @IBOutlet weak var funcDigits: UILabel!
    
    @IBAction func sayDisplay(sender:AnyObject) {
    SoundOut(0)
    }

    @IBAction func copytoClipboard(sender: AnyObject) {
        
        UIPasteboard.generalPasteboard().string = display.text
    }
    
    //displaying digits
    @IBOutlet weak var display: UILabel!
    
    var memory:[String:String] = ["M1":"", "M2":"", "M3":""]
    
    @IBAction func memoryDelete(sender: AnyObject) {
        let key = "M\(sender.tag+1)"
        sender.setTitle(key, forState: .Normal)
        memory[key] = ""
    }
    
    
    @IBAction func memoryButton(sender: UIButton) {

        let key = "M\(sender.tag+1)"
        
        if memory[key] == "" {
            let MR = display.text
            memory[key] = MR
            sender.setTitle(MR, forState: .Normal)
        }
        else {
            display.text = memory[key]
            userIsInTheMiddleOfTyping = true        }
    }
    
    @IBAction func exportResult(sender: UIButton) {
    }
    @IBAction func clearCalc(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            let textInTheCurrentDisplay = display.text!
            display.text = String(textInTheCurrentDisplay.characters.dropLast())
            if display.text == "" {
                display.text="0"
            userIsInTheMiddleOfTyping = false
            }
            
        } else {
        display.text = "0"
        userIsInTheMiddleOfTyping = false
        }
    }
    
    
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit (sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textInTheCurrentDisplay = display.text!
                    if digit == "0" && display.text == "0" {
                            display.text = "0"
                            userIsInTheMiddleOfTyping = false
                                                    } else {
                    if display.text == "0"  {
                        display.text = digit
                    } else {
                        display.text = textInTheCurrentDisplay + digit}
            }
        } else {
            if digit == "." { display.text = "0\(digit)"}
            else {
                display.text = digit
            }

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
        
        do {
//            let resourcePath =  NSBundle.mainBundle().pathForResource("Timer", ofType: "wav")!
//            let url = NSURL(fileURLWithPath: resourcePath)
//            try timerEffectplayer = AVAudioPlayer(contentsOfURL: url)
//            try timerLoudRingplayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("TimerLoudRing", ofType: "wav")!))
//            try timerShortRingplayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("TimerShortRing", ofType: "wav")!))
//            try timerRewindplayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("TimerRewind", ofType: "wav")!))
//            
//            timerEffectplayer.numberOfLoops = -1
//            timerEffectplayer.prepareToPlay()
//            timerLoudRingplayer.prepareToPlay()
//            timerShortRingplayer.prepareToPlay()
//            timerRewindplayer.prepareToPlay()
            
            
            
        } catch let err as NSError {
            print (err.debugDescription)
        }


    }
    
    @IBAction func counterViewSwipe (gesture:UISwipeGestureRecognizer?) {
        if (isBasicShowing) {
            UIView.transitionFromView(BasicPad,
                                      toView:FunctionPad,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion:nil)
                                        funcDigits.text = display.text
        } else {
            UIView.transitionFromView(FunctionPad,
                                      toView: BasicPad,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
                                        display.text = funcDigits.text}
                isBasicShowing = !isBasicShowing
    }
    
    @IBAction func counterViewSwipeback (gesture:UISwipeGestureRecognizer?) {
        if (isBasicShowing) {
            UIView.transitionFromView(BasicPad,
                                      toView:FunctionPad,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight
                                        , UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion:nil)
            funcDigits.text = display.text
        } else {
            UIView.transitionFromView(FunctionPad,
                                      toView: BasicPad,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight
                                        , UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
            display.text = funcDigits.text}
        isBasicShowing = !isBasicShowing
    }

    func SoundOut(index: Int){
        if index == 0 {
            print ("sound shoud be out!")
            sayCount = AVSpeechUtterance(string: display.text!)
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 1 {
            buttonclickplayer.play()}
        else if index == 2 {
            resultplayer.play()}
        else if index == 3 {
            swipingplayer.play()}
    }

    
}

