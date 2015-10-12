//
//  CheckMarkRecognizer.swift
//  CheckPlease
//
//  Created by Edgar on 8/18/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CheckMarkRecognizer: UIGestureRecognizer {
   
    private let minimumCheckMarkAngle = CGFloat(50)
    private let maximumCheckMarkAngle = CGFloat(135)
    private let minimumChackMarkLength = CGFloat(10)
    private var lastPreviousPoint = CGPointZero
    private var lastCurrentPoint =  CGPointZero
    private var lineLengthSoFar = CGFloat(0)
    
    
    override func touchesBegan(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesBegan(touches, withEvent: event)
        let touch = touches.first as! UITouch
        let point = touch.locationInView(view)
        lastPreviousPoint = point
        lastCurrentPoint = point
        lineLengthSoFar = 0
    }
    
    override func touchesMoved(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesMoved(touches, withEvent: event)
        let touch = touches.first as! UITouch
        let previousPoint = touch.previousLocationInView(view)
        let currentPoint = touch.locationInView(view)
        let angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint, previousPoint, currentPoint)
        
        
        NSLog("\(angle) angle and length: \(lineLengthSoFar)")
        if angle >= minimumChackMarkLength && angle <= maximumCheckMarkAngle && lineLengthSoFar > minimumChackMarkLength {
            state = .Ended
        }
        
        lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint)
        lastPreviousPoint = previousPoint
        lastCurrentPoint = currentPoint
    }
}
