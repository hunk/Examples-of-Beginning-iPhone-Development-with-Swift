//
//  ViewController.swift
//  MotionMonitor
//
//  Created by Edgar on 9/7/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var gryroscopeLabel:UILabel!
    @IBOutlet var accelerometerLabel:UILabel!
    @IBOutlet var attitudeLabel:UILabel!
    
    private let motionManager = CMMotionManager()
//    private let queue = NSOperationQueue()
    private var updateTimer:NSTimer!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates()
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateDisplay", userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if motionManager.deviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
            updateTimer.invalidate()
            updateTimer = nil
        }
    }
    
    
    func updateDisplay() {
        let motion = motionManager.deviceMotion
        if (motion != nil) {
            let rotationRate = motion.rotationRate
            let gravity = motion.gravity
            let userAcc = motion.userAcceleration
            let attitude = motion.attitude

            let gyroscopeText = String(format: "Rotation Rate:\n-----------\n" +
                "x: %+.2f\n y: %+.2f\n z: %+.2f\n",rotationRate.x,rotationRate.y,rotationRate.z)

            let acceleratorText = String(format: "Acceleration:\n-----------\n" +
                "Gravity x:%+.2f\t\tUser x:%+.2f\n" +
                "Gravity y:%+.2f\t\tUser y:%+.2f\n" +
                "Gravity z:%+.2f\t\tUser z:%+.2f\n"
                ,gravity.x,userAcc.x,gravity.y,userAcc.y,gravity.z,userAcc.z)

            let attitudeText = String(format: "Attitude:\n------\n" +
                "Roll: %+.2f\nPitch: %+.2f\nYaw: %+.2f\n"
                ,attitude.roll,attitude.pitch,attitude.yaw)


            dispatch_async(dispatch_get_main_queue() , {
                self.gryroscopeLabel.text = gyroscopeText
                self.accelerometerLabel.text = acceleratorText
                self.attitudeLabel.text = attitudeText
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if motionManager.deviceMotionAvailable {
//            motionManager.deviceMotionUpdateInterval = 0.1
//            motionManager.startDeviceMotionUpdatesToQueue(queue, withHandler: { (motion:CMDeviceMotion!, error:NSError!) -> Void in
//                let rotationRate = motion.rotationRate
//                let gravity = motion.gravity
//                let userAcc = motion.userAcceleration
//                let attitude = motion.attitude
//                
//                let gyroscopeText = String(format: "Rotation Rate:\n-----------\n" +
//                    "x: %+.2f\n y: %+.2f\n z: %+.2f\n",rotationRate.x,rotationRate.y,rotationRate.z)
//                
//                let acceleratorText = String(format: "Acceleration:\n-----------\n" +
//                    "Gravity x:%+.2f\t\tUser x:%+.2f\n" +
//                    "Gravity y:%+.2f\t\tUser y:%+.2f\n" +
//                    "Gravity z:%+.2f\t\tUser z:%+.2f\n"
//                    ,gravity.x,userAcc.x,gravity.y,userAcc.y,gravity.z,userAcc.z)
//                
//                let attitudeText = String(format: "Attitude:\n------\n" +
//                    "Roll: %+.2f\nPitch: %+.2f\nYaw: %+.2f\n"
//                    ,attitude.roll,attitude.pitch,attitude.yaw)
//                
//                
//                dispatch_async(dispatch_get_main_queue() , {
//                    self.gryroscopeLabel.text = gyroscopeText
//                    self.accelerometerLabel.text = acceleratorText
//                    self.attitudeLabel.text = attitudeText
//                })
//                
//            })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

