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

    var CountedNumber: Int = 0
    var lengthCountedNumber: Int = 0
    var countingSound: AVAudioPlayer!
    var startTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("counting", ofType: "wav")
        let soundUrl = NSURL (fileURLWithPath: path!)
        
        do {
            try countingSound = AVAudioPlayer(contentsOfURL: soundUrl)
            countingSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBOutlet weak var CurrentCount:
    UILabel!
    
    @IBAction func AddCount(sender: UIButton) {
        CountedNumber = CountedNumber + 1
        if CountedNumber == 1 { startTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)}
        SetCount (CountedNumber)
        playSound ()
    }
    
    @IBAction func ResetCount(sender: UIButton) {
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
    
    func SetCount (countnumb: Int) {
        CurrentCount.text = String(countnumb)
         CurrentCount.kerning = 15
    
    }
    

    
    @IBAction func CopyCount(sender: UIButton) {
        let endTime = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        UIPasteboard.generalPasteboard().string = "Counted: " + String(CountedNumber) + " times " + "from \(startTime) to \(endTime)"
    }
    
    func playSound () {
        if countingSound.playing {
            countingSound.stop()
        } else {
            countingSound.play()
        }
    }
    
}



