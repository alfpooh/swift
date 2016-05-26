//
//  ViewController.swift
//  Smart Tally Counter
//
//  Created by donghoon bae on 2016. 5. 25..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var CountedNumber: Int = 0
    
    @IBOutlet weak var CurrentCount: UILabel!
    
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
        SetCount (CountedNumber)
    }
    
    func SetCount (countnumb: Int) {CurrentCount.text = String(countnumb)
    
    }
}

