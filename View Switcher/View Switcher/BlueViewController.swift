//
//  BlueViewController.swift
//  View Switcher
//
//  Created by Edgar on 5/12/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func blueButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: "Blue View Button Pressed", message: "You pressed the button on the blue view", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Yep, i did", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func supportedInterfaceOrientations() -> Int {
        NSLog("here")
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
