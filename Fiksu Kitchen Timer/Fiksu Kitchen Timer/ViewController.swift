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
    let targetTime = "00:15"
    var isPaused = false
    var pausedTime: Float!
    var timer = NSTimer()
    
    @IBOutlet weak var targetTimeLabel: UILabel!

    
    @IBOutlet weak var elapsedTimeLabel: UILabel!

    let watch = Watch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        
        if isPaused == true {
            // for resume
            
             resumeTimer(pausedTime)
        }
            
        else {
            // for pause
            pausedTime = Float(watch.elapsedTime)
            print ("Paused recorded at \(self.pausedTime)")
            timer.invalidate()
            //watch.stop()
        }
        self.pausedTime = 0.0
        isPaused = !isPaused
        
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        if !timer.valid {timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                                                           selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)}
        
        targetTimeLabel.text = targetTime
        watch.start()
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        watch.stop()
    }
    
    func resumeTimer(lastTime: Float) {
 
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
            if targetTime == elapsedTimeLabel.text {
                timer.invalidate()
                watch.stop()
                VoiceOut()
            }
            // normally update label with new elapsed time
            elapsedTimeLabel.text = watch.elapsedTimeAsString
        } else {
            // if watch is not running, off timer.
            timer.invalidate()
        }
    }

    
}

