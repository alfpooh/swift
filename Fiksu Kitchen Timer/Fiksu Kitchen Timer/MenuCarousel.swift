//
//  ViewController.swift
//  Fiksu Kitchen Timer
//
//  Created by donghoon bae on 2016. 7. 1..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit
import AVFoundation


class MenuViewController: UIViewController, ZCarouselDelegate {
    
   // var menu: ZCarousel!
    var images: ZCarousel!
    var currentIndex: Int!

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //menu = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5,
            //y: 100,
            //width: (self.view.frame.size.width/5)*3,
            //height: 50))
        //menu.ZCdelegate = self
       // menu.addButtons(["iOS 8 by Tutorials", "Swift by Tutorials", "Core Data by Tutorials", "WatchKit by Tutorials"])
        
       // self.view.addSubview(menu!)
        
        images = ZCarousel(frame: CGRect( x: self.view.frame.size.width/5-10,
            y: 100,
            width: ((self.view.frame.size.width/5)*3),
            height: (self.view.frame.size.width/5)*3))
        images.ZCdelegate = self
        
        images.addImages(["InstantRamen", "Fusilli", "Potatoes", "Spagehtti","Somen","Egg"])
        

        self.view.addSubview(images)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GotoTimer), name: "starttimer", object: nil)
    }
    
    func GotoTimer(sender: AnyObject) {

                if currentIndex == nil {currentIndex = 0}
                let str = "\(currentIndex)"
                performSegueWithIdentifier("GoTimer", sender: str)

    }
    
    func ZCarouselShowingIndex(scrollview: ZCarousel, index: Int) {
        //if scrollview == menu {
        //    print("Showing Button at index \(index)")
        //}
        //else if scrollview == images {
            print("Showing Image at index \(index)")
        currentIndex = index
       // }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //This is where you do work right before the view loads
        //keep in mind - the next View controller has already been initialized
        if segue.identifier == "GoTimer" {
            if let ViewController = segue.destinationViewController as? ViewController {
                
                if let theString = sender as? String {
                    ViewController.transferText = String(theString)
                }
            }
        }
        
    }
 
}

