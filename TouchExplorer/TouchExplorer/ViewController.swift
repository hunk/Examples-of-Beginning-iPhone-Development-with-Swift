//
//  ViewController.swift
//  TouchExplorer
//
//  Created by Edgar on 8/14/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var tapsLabel:UILabel!
    @IBOutlet var touchesLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabelsFromTouches(touches:NSSet!){
        let touch = touches.anyObject() as! UITouch
        let numTaps = touch.tapCount
        let tapsMessage = "\(numTaps) taps detected"
        tapsLabel.text =  tapsMessage
        
        let numTouches = touches.count
        let touchMsg = "\(numTouches) touches detected"
        touchesLabel.text = touchMsg
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        messageLabel.text = "Touches Began"
        updateLabelsFromTouches(event.allTouches())
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        messageLabel.text = "Touches Cancelled"
        updateLabelsFromTouches(event.allTouches())
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        messageLabel.text = "Touches Ended"
        updateLabelsFromTouches(event.allTouches())
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        messageLabel.text = "Touches Moved"
        updateLabelsFromTouches(event.allTouches())
    }
    
    
}

