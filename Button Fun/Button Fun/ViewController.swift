//
//  ViewController.swift
//  Button Fun
//
//  Created by Edgar on 3/19/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet var statusLabel: UILabel!
    @IBAction func buttonPressed(sender: UIButton) {
        
        let title = sender.titleForState(.Normal)!
        let plainText = "\(title) button pressed"
        statusLabel.text = plainText
        
        let styledText = NSMutableAttributedString(string: plainText)
        let attribute = [
            NSFontAttributeName:
                UIFont.boldSystemFontOfSize(statusLabel.font.pointSize)
        ]
        let nameRange = (plainText as NSString).rangeOfString(title)
        styledText.setAttributes(attribute, range: nameRange)
        statusLabel.attributedText = styledText
    }


}

