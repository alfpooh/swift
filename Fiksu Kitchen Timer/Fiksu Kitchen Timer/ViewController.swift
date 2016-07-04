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
    let targetTime = ["12:00","15:00","10:00","04:00","14:00","05:00"]
    var isPaused = false
    var pausedTime: NSTimeInterval!
    var timer = NSTimer()
    var transferText: String! = ""
    
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

        targetTimeLabel.text = targetTime[timerindex]
        print ("timerindex: \(timerindex), targetTimelabel: \(targetTimeLabel.text)")
    }
    
    @IBAction func PlusMinute(sender: AnyObject) {
        watch.addOneMinute()
    }
    
    
    @IBAction func MinusMinute(sender: AnyObject) {
        watch.minusOneMinute()
    }
    
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        
        if isPaused == true {
            // for resume
            
             resumeTimer(pausedTime)
        }
            
        else {
            // for pause
            watch.pause()
            timer.invalidate()
            //watch.stop()
        }
        self.pausedTime = 0.0
        isPaused = !isPaused
        
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        if !timer.valid {timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                                           selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)}
        
        watch.start()
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        watch.stop()
    }
    
    func resumeTimer(lastTime: NSTimeInterval) {
 
        print("\(lastTime)")
        if !timer.valid {NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                                selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
                        }

        
        watch.start()
    }
    
    func VoiceOut(){
        sayCount = AVSpeechUtterance(string: "Time out!")
        sayCount.rate = 0.5
        synth.speakUtterance(sayCount)
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
                VoiceOut()
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

