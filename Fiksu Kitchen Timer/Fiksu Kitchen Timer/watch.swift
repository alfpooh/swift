//
//  watch.swift
//  Fiksu Kitchen Timer
//
//  Created by donghoon bae on 2016. 7. 1..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import Foundation

class Watch {
    
   var startTime: NSDate!
    
    var elapsedTime: NSTimeInterval {
        if let startTime = self.startTime {
            print (-startTime.timeIntervalSinceNow)
            return -startTime.timeIntervalSinceNow
            
        } else {
            return 0
        }
    }
    
    var elapsedTimeAsString: String {
        return String(format: "%02d:%02d",
                      Int(elapsedTime / 60), Int(elapsedTime % 60))
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = NSDate()
    }

    
    func stop() {
        startTime = nil
    }
    
}