//
//  ViewController.swift
//  Fiksu Kitchen Timer
//
//  Created by donghoon bae on 2016. 7. 1..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    let synth = AVSpeechSynthesizer()
    var sayCount = AVSpeechUtterance(string: "")
    let targetTime = [5,12,15,10,4,14]
    var isPaused = false
    var pausedTime: NSTimeInterval!
    var timer = NSTimer()
    var transferText: String! = "0"
    
    @IBOutlet weak var targetTimeLabel: UILabel!

    
    @IBOutlet weak var elapsedTimeLabel: UILabel!

    let watch = Watch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //target time should be decided from selecting menu later!
        let timerindex = Int(transferText)!
        if targetTime[timerindex] < 10 {
        targetTimeLabel.text = "0\(targetTime[timerindex]):00"
        } else {
        targetTimeLabel.text = "\(targetTime[timerindex]):00"}
        print ("timerindex: \(timerindex), targetTimelabel: \(targetTimeLabel.text)")
    }
    
    @IBAction func PlusMinute(sender: AnyObject) {
        if timer.valid {
        watch.addOneMinute()
        VoiceOut(5)
        }
    }
    
    @IBAction func backtomenu(sender: AnyObject) {
        if timer.valid { watch.pause()
        timer.invalidate()
            dismissViewControllerAnimated(true, completion: nil)}
        
    }
    
    @IBAction func MinusMinute(sender: AnyObject) {
        if timer.valid {
        watch.minusOneMinute()
        VoiceOut(6)
        }
    }
    
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        
        if isPaused == true {
            // for resume
            
             resumeTimer(pausedTime)
        }
            
        else {
            // for pause
            
            watch.pause()
            VoiceOut(3)
            timer.invalidate()
        }
        self.pausedTime = 0.0
        isPaused = !isPaused
        
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        
        if !timer.valid {timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                                           selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
        VoiceOut(0)
            watch.start()} else {
        print ("play button is pressed while timer counting")
        }
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        watch.stop()
    }
    
    func resumeTimer(lastTime: NSTimeInterval) {
 
        print("\(lastTime)")
         VoiceOut(4)
        if !timer.valid {NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                                selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
                        }

        
        watch.start()
    }
    
    func VoiceOut(index: Int){
        if index == 0 {
        sayCount = AVSpeechUtterance(string: "Timer Starts")
        sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 1 {
            sayCount = AVSpeechUtterance(string: "Time out!")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
         else if index == 2 {
            sayCount = AVSpeechUtterance(string: "One minute left")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 3 {
            sayCount = AVSpeechUtterance(string: "Timer paused")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 4 {
            sayCount = AVSpeechUtterance(string: "Timer continues")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 5 {
            sayCount = AVSpeechUtterance(string: "Jump one minute")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
        else if index == 6 {
            sayCount = AVSpeechUtterance(string: "One minute more")
            sayCount.rate = 0.5
            synth.speakUtterance(sayCount)}
    }



    func updateElapsedTimeLabel(timer: NSTimer) {
        
        // for paused.
        if isPaused == true {
            watch.start()
            return
        }
        // normally timer is running now
        if watch.isRunning {
            
            // if it is target time stop and alert
            if targetTimeLabel.text == elapsedTimeLabel.text {
                VoiceOut(1)
                timer.invalidate()
                
            }
            // normally update label with new elapsed time
            elapsedTimeLabel.text = watch.elapsedTimeAsString
        } else {
            // if watch is not running, off timer.
            timer.invalidate()
        }
    }

    
}

