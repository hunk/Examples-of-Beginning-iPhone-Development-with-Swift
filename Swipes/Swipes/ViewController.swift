//
//  ViewController.swift
//  Swipes
//
//  Created by Edgar on 8/14/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
//    private var gestureStartPoint: CGPoint!
//    
//    private let minimumGestureLength = Float(25.0)
//    private let maximumVariance = Float(5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        for var touchesCount = 1; touchesCount <= 5; touchesCount++ {
//            let vertical = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
//            vertical.direction = UISwipeGestureRecognizerDirection.Up | UISwipeGestureRecognizerDirection.Down
//            vertical.numberOfTouchesRequired = touchesCount
//            view.addGestureRecognizer(vertical)
//            
//            let horizontal = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
//            horizontal.direction = UISwipeGestureRecognizerDirection.Left | UISwipeGestureRecognizerDirection.Right
//            horizontal.numberOfTouchesRequired = touchesCount
//            view.addGestureRecognizer(horizontal)
//        }
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTap")
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap")
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(doubleTap)
        
        singleTap.requireGestureRecognizerToFail(doubleTap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        let touch = touches.first as? UITouch
//        gestureStartPoint = touch?.locationInView(self.view)
//    }
//    
//    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
//        let touch = touches.first as? UITouch
//        let currentPosition = touch?.locationInView(self.view)
//        
//        let deltaX = fabs(Float(gestureStartPoint.x - currentPosition!.x))
//        let deltaY = fabs(Float(gestureStartPoint.y - currentPosition!.y))
//        
//        if deltaX >= minimumGestureLength && deltaY <= maximumVariance {
//            label.text = "Horizontal swipe detected"
//            dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
//                self.label.text = ""
//            })
//        } else if deltaY > minimumGestureLength && deltaX <= maximumVariance {
//            label.text = "Vertical swipe detected"
//            dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
//                self.label.text = ""
//            })
//        }
//    }

    func reportHorizontalSwipe(recongnizer: UIGestureRecognizer) {
//        label.text = "Horizontal swipe detected"
        let count = descriptionForTouchCount(recongnizer.numberOfTouches())
        label.text = "\(count) Horizontal swipe detected"
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            self.label.text = ""
        })
    }
    
    func reportVerticalSwipe(recongnizer: UIGestureRecognizer) {
//        label.text = "Vertical swipe detected"
        let count = descriptionForTouchCount(recongnizer.numberOfTouches())
        label.text = "\(count) Vertical swipe detected"
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            self.label.text = ""
        })
    }
    
    func descriptionForTouchCount(touchCount:Int) -> String {
        switch touchCount {
        case 1:
            return "Single"
        case 2:
            return "Double"
        case 3:
            return "Triple"
        case 4:
            return "Quadruple"
        case 5:
            return "Quintuple"
        default:
            return ""
        }
    }

}

