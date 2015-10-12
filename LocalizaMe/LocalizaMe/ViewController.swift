//
//  ViewController.swift
//  LocalizaMe
//
//  Created by Edgar on 9/14/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var localeLabel:UILabel!
    @IBOutlet var flagImageView:UIImageView!
    @IBOutlet var labels:[UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let locale = NSLocale.currentLocale()
        let currentLangID = (NSLocale.preferredLanguages() as! [String])[0]
        let displayLang = locale.displayNameForKey(NSLocaleLanguageCode, value: currentLangID)
        let capitalized = displayLang?.capitalizedStringWithLocale(locale)
        localeLabel.text = capitalized
        
        labels[0].text = NSLocalizedString("LABEL_ONE", comment: "the number 1")
        labels[1].text = NSLocalizedString("LABEL_TWO", comment: "the number 2")
        labels[2].text = NSLocalizedString("LABEL_THREE", comment: "the number 3")
        labels[3].text = NSLocalizedString("LABEL_FOUR", comment: "the number 4")
        labels[4].text = NSLocalizedString("LABEL_FIVE", comment: "the number 5")
        
        let flagFile =  NSLocalizedString("FLAG_FILE", comment: "name of the flag")
        flagImageView.image = UIImage(named: flagFile)
        
        NSLog("current locale \(locale)")
        NSLog("currentLangID \(currentLangID)")
        NSLog("displayLang \(displayLang)")
        
        let more = (NSLocale.preferredLanguages() as! [String])
        NSLog("more \(more)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

