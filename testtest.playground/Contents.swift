//: Playground - noun: a place where people can play

import UIKit
let date3 = NSDate()

let calendar = NSCalendar.currentCalendar()
let component = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: date3)

print(component.year)
print(component.month)
print(component.day)
print(component.hour)
print(component.minute)
print(component.second)

var date1 = NSDate()
var date2 = NSDate(timeIntervalSinceNow: 9 * 60 * 60)

var diffsec = date2.timeIntervalSinceDate(date1)

print(diffsec)


let formatdate = NSDateFormatter()
formatdate.dateFormat = "yyyy/MM/dd HH:mm:ss"
let nowdate = formatdate.stringFromDate(date1)
print(nowdate)

let date11 = formatdate.dateFromString("2016-may-02 12:01:03")
print(date11)

func returnSomethingCool() -> Bool {
    return true
}

If returnSomethingCool() { print "it is true." } else { print "it is not true" }


