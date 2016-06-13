//
//  ViewController.swift
//  Smart Tally Counter
//
//  Created by donghoon bae on 2016. 5. 25..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import AVFoundation

// UILabel Kerining extention
// refered from http://stackoverflow.com/questions/7370013/how-to-set-kerning-in-iphone-uilabel?lq=1

extension UILabel {
    
    @IBInspectable var kerning: Float {
        get {
            var range = NSMakeRange(0, (text ?? "").characters.count)
            guard let kern = attributedText?.attribute(NSKernAttributeName, atIndex: 0, effectiveRange: &range),
                value = kern as? NSNumber
                else {
                    return 0
            }
            return value.floatValue
        }
        set {
            var attText:NSMutableAttributedString?
            
            if let attributedText = attributedText {
                attText = NSMutableAttributedString(attributedString: attributedText)
            } else if let text = text {
                attText = NSMutableAttributedString(string: text)
            } else {
                attText = NSMutableAttributedString(string: "")
            }
            
            let range = NSMakeRange(0, attText!.length)
            attText!.addAttribute(NSKernAttributeName, value: NSNumber(float: newValue), range: range)
            self.attributedText = attText
        }
    }
}



class ViewController: UIViewController {
    var isGraphViewShowing = false
    let synth = AVSpeechSynthesizer()
    var sayCount = AVSpeechUtterance(string: "")
    var soundMute = false
    var countLog = [Int]()
    var countperminLog = [Float]()
    var CountedNumber: Int = 0
    var lengthCountedNumber: Int = 0
    var countingSound: AVAudioPlayer!
    var startTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    var startTimestamp = NSDate()
    var logtext = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("counterclick", ofType: "m4a")
        let soundUrl = NSURL (fileURLWithPath: path!)
        
        do {
            try countingSound = AVAudioPlayer(contentsOfURL: soundUrl)
            countingSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBOutlet weak var CurrentCount: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var LenseView: UIView!
    
    @IBOutlet weak var Abouttext: UILabel!
    
    @IBAction func AddCount(sender: UIButton) {
        CountedNumber = CountedNumber + 1
        if CountedNumber == 1 {
            startTimestamp = NSDate()
            startTime = NSDateFormatter.localizedStringFromDate(startTimestamp, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        }
        SetCount (CountedNumber)
        playSound ()
    }
    
    @IBAction func ResetCount(sender: UIButton) {
            countlogging (CountedNumber)        
            CountedNumber = 0
            SetCount (CountedNumber)
        
    }
    
    @IBAction func MinusCount(sender: UIButton) {
        CountedNumber = CountedNumber - 1
        if CountedNumber < 0 {
        CountedNumber = 0
        }
        SetCount (CountedNumber)
        playSound ()
    }
    
    func ResetCountf () {
        countlogging (CountedNumber)
        CountedNumber = 0
        SetCount (CountedNumber)
    }
    
    func countlogging (countforlog: Int) {
        var CountlogperMin = countperMin(countforlog)
        if countLog.count == 6 {
            countLog.removeAtIndex(0)
            countLog.append(countforlog)
        //print ("first array deleted and add this: \(countforlog)")
            Abouttext.text = ""}
        else {
            countLog.append(countforlog)
    }
        if countperminLog.count == 6 {
            countperminLog.removeAtIndex(0)
            countperminLog.append(CountlogperMin)
            //print ("first array deleted and add this: \(countforlog)")
            }
        else {
            countperminLog.append(CountlogperMin)
        }
    
}
    
        
    func SetCount ( countnumb: Int) {
         CurrentCount.kerning = 15
        if countnumb < 10 {
        CurrentCount.text = "000" + String(countnumb)
        } else if countnumb < 100 && countnumb >= 10 {
        CurrentCount.text = "00" + String(countnumb)
        } else if countnumb < 1000 && countnumb >= 100 {
            CurrentCount.text = "0" + String(countnumb)
        } else if countnumb < 10000 && countnumb >= 1000 {
            CurrentCount.text = String(countnumb)
        } else if countnumb >= 10000 {
            CurrentCount.text = "00000"
            var countnumb = 0
        }
    }
    

    
    func playSound () {
        if !soundMute {
        if countingSound.playing {
            countingSound.stop()
        } else {
            countingSound.play()
        }
        }
    }
    
    @IBAction func VoiceOut(sender: AnyObject) {
        sayCount = AVSpeechUtterance(string: String(CountedNumber))
        sayCount.rate = 0.5
        synth.speakUtterance(sayCount)
        
    }



    @IBAction func LogExport(sender: AnyObject) {
        
       copytoclipboard()
        
    }
    

        
    
    @IBAction func counterViewSwipe (gesture:UISwipeGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transitionFromView(graphView,
                                      toView: LenseView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion:nil)
            
            
        } else {
            
            //show Graph
            
            // set hide for now setupGraphDisplay()
            
            UIView.transitionFromView(LenseView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
        //old text log list start
        //    logtext = ""
        //    var numberofLog = 0
        //    if countLog.count == 0 {
        //    numberofLog = countLog.count
        //        logtext = "No count log."
        //    } else {
        //
        //        numberofLog = countLog.count - 1
        //
        //    for countindex in 0...numberofLog {
        //        let cpm = String(format: "%.1f", countperminLog[countindex])
        //        let csec = String(format: "%.0f", (Float(countLog[countindex])*60)/countperminLog[countindex])
        //            logtext = logtext + ("Lap \(countindex) : \(countLog[countindex]) permin: \(cpm) for \(csec) secs.\n")
        //        }}

        }
        //Abouttext.text = logtext
        //old text log list end
            
        isGraphViewShowing = !isGraphViewShowing
    }
    @IBAction func counterViewSwipeleft (gesture:UISwipeGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            UIView.transitionFromView(graphView,
                                      toView: LenseView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion:nil)
            
        } else {
            
            //show Graph
            
            // set hide for now setupGraphDisplay()
            
            UIView.transitionFromView(LenseView,
                                      toView: graphView,
                                      duration: 1.0,
                                      options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews],
                                      completion: nil)
            Abouttext.text = "All app design including graphic, font, background, sound, and coding \n by Dr. Alf.\n\r All Right Reserved. Forethink. 2016\r support@forethink.nu "
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    func countperMin (countedpara: Int) -> Float{
        let endTime = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let elapsedTime = NSDate().timeIntervalSinceDate(endTime)
        let datecomponenets = calendar.components(NSCalendarUnit.Second, fromDate:startTimestamp, toDate:endTime, options: [])
        let seconds = datecomponenets.second
        var perMin = Float(Float(countedpara)/(Float(seconds)/60))
        return perMin
    }
    
    func copytoclipboard() {
        let endTime = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let elapsedTime = NSDate().timeIntervalSinceDate(endTime)
        let datecomponenets = calendar.components(NSCalendarUnit.Second, fromDate:startTimestamp, toDate:endTime, options: [])
        let seconds = datecomponenets.second

        //let seconds = datecomponenets.second
        
        //var perMin = Float(Float(CountedNumber)/(Float(seconds)/60))
        var CountlogperMin = countperMin(CountedNumber)
        
        
        UIPasteboard.generalPasteboard().string = "Counted: " + String(CountedNumber) + " times " + " for \(seconds) seconds , from \(startTime) , \(CountlogperMin ) per a minutes."
        playSound()
    }

    @IBAction func showAlertTapped(sender: AnyObject) {
        //Create the AlertController
        let countResult = "Counted: " + String(CountedNumber) + " times "
        let myAlertController: UIAlertController = UIAlertController(title: "Copying to Clipboard", message: countResult, preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        myAlertController.addAction(cancelAction)
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Copy", style: .Default) { action -> Void in
            
            self.copytoclipboard()
                    }
        myAlertController.addAction(nextAction)
        
        
        //Present the AlertController
        self.presentViewController(myAlertController, animated: true, completion: nil)
    }

}