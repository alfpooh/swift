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
    let isPaused = false
    
    @IBOutlet weak var targetTimeLabel: UILabel!

    
    @IBOutlet weak var elapsedTimeLabel: UILabel!

    let watch = Watch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func pauseButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func startButtonTapped(sender: UIButton) {
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self,
                                               selector: #selector(ViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
        targetTimeLabel.text = targetTime
        watch.start()
    }
    
    @IBAction func stopButtonTapped(sender: UIButton) {
        watch.stop()
    }
    
    func VoiceOut(){
        sayCount = AVSpeechUtterance(string: "Time out!")
        sayCount.rate = 0.5
        synth.speakUtterance(sayCount)
    }
    
    func updateElapsedTimeLabel(timer: NSTimer) {
        if watch.isRunning {
            elapsedTimeLabel.text = watch.elapsedTimeAsString
            if targetTime == elapsedTimeLabel.text {
                timer.invalidate()
                watch.stop()
                VoiceOut()
            }
        } else {
            timer.invalidate()
        }
    }
    
}

