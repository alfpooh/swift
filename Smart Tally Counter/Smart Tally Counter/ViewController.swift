//
//  ViewController.swift
//  Smart Tally Counter
//
//  Created by donghoon bae on 2016. 5. 25..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var CurrentCount:
    UILabel!
    
    @IBAction func AddCount(sender: UIButton) {
        CountedNumber = CountedNumber + 1
        SetCount (CountedNumber)
        return
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
    }
    
    func SetCount (countnumb: Int) {
        CurrentCount.text = String(countnumb)
         CurrentCount.kerning = 15
    
    }
    @IBAction func CopyCount(sender: UIButton) {
        UIPasteboard.generalPasteboard().string = String(CountedNumber)
    }
    
}

