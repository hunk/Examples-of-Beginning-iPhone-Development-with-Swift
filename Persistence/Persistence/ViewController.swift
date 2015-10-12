//
//  ViewController.swift
//  Persistence
//
//  Created by Edgar on 8/7/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!
    private let rootKey = "rootKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filePath = self.dataFilePath()
        if ( NSFileManager.defaultManager().fileExistsAtPath(filePath) ) {
//            let array = NSArray(contentsOfFile: filePath) as! [String]
//            for var i = 0; i < array.count; i++ {
//                lineFields[i].text = array[i]
//            }
            let data =  NSMutableData(contentsOfFile: filePath)!
            let unarchiver =  NSKeyedUnarchiver(forReadingWithData: data)
            let fourLines = unarchiver.decodeObjectForKey(rootKey) as? FourLines
            unarchiver.finishDecoding()
            
            if let newLines = fourLines?.lines {
                for var i = 0; i < newLines.count; i++ {
                    lineFields[i].text =  newLines[i]
                }
            }
        }
        
        let app =  UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResingActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
//        return documentsDirectory.stringByAppendingPathComponent("data.plist") as String
        return documentsDirectory.stringByAppendingPathComponent("data.archive") as String
    }
    
    func applicationWillResingActive(notification: NSNotification) {
        let filePath = self.dataFilePath()
//        let array = (self.lineFields as NSArray).valueForKey("text") as! NSArray
//        array.writeToFile(filePath, atomically: true)
        let fourLines =  FourLines()
        let array = (self.lineFields as NSArray).valueForKey("text") as! [String]
        fourLines.lines = array
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(fourLines, forKey: rootKey)
        archiver.finishEncoding()
        data.writeToFile(filePath, atomically: true)
    }


}

