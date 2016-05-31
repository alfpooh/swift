//
//  ViewController.swift
//  oldchool
//
//  Created by donghoon bae on 2016. 5. 28..
//  Copyright © 2016년 Forethink. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    
    var names = ["Apple ][+ \n","Loading...\n","]","?"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainLbl.text = ""
        var text = ""
        
        for name in names {
            text = text + name
            mainLbl.text = text
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

