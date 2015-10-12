//
//  RootViewController.swift
//  Presidents
//
//  Created by Edgar on 8/6/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class RootViewController: UINavigationController {

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
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        let splitVC = viewControllers[0] as! UISplitViewController
        let newTrails =  traitCollection
        if newTrails.horizontalSizeClass == .Compact && newTrails.verticalSizeClass == .Compact {
            let childTraits = UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular)
            setOverrideTraitCollection(childTraits, forChildViewController: splitVC)
        }else{
            setOverrideTraitCollection(nil, forChildViewController: splitVC)
        }
    }

}
