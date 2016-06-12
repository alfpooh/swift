    //
//  GraphView.swift
//  Smart Count
//
//  Created by donghoon bae on 2016. 6. 8..
//  Copyright © 2016년 Forethink. All rights reserved.
//

    import UIKit
    
    class GraphView: UIView {
        @IBInspectable var graphColor: UIColor = UIColor.blueColor()
        @IBInspectable var graphstrokeColor: UIColor = UIColor.blueColor()
        @IBInspectable var lineWidth: CGFloat = 3.0
        
        override func drawRect(rect: CGRect) {
            var graphbasePath = UIBezierPath(ovalInRect: rect)
            graphbasePath.lineWidth = lineWidth
            graphColor.setFill()
            graphstrokeColor.setStroke()
            graphbasePath.stroke()
            graphbasePath.fill()
            
            
        }

}
