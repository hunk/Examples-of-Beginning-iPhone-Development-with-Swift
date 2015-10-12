//
//  SecondViewController.swift
//  Bridge Control
//
//  Created by Edgar on 8/6/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var engineSiwtch: UISwitch!
    @IBOutlet var warpFactorSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func engineSiwtchRapped(sender: AnyObject) {
        let defaults =  NSUserDefaults.standardUserDefaults()
        defaults.setBool(engineSiwtch.on, forKey: warpDriveKey)
        defaults.synchronize()
    }
    
    
    @IBAction func warpSliderTouched(sender: AnyObject) {
        let defaults =  NSUserDefaults.standardUserDefaults()
        defaults.setFloat(warpFactorSlider.value, forKey: warpFactorKey)
        defaults.synchronize()
    }
    
    
    @IBAction func settingsButtonClicked(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: app)
    }
    
    func refreshFields() {
        let defaults =  NSUserDefaults.standardUserDefaults()
        engineSiwtch.on = defaults.boolForKey(warpDriveKey)
        warpFactorSlider.value =  defaults.floatForKey(warpFactorKey)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        let defaults =  NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
        refreshFields()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

