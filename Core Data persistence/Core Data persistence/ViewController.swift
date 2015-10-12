//
//  ViewController.swift
//  Core Data persistence
//
//  Created by Edgar on 8/11/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!
    private let lineEntityName = "Line"
    private let lineNumberKey = "lineNumber"
    private let lineTextKey = "lineText"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: lineEntityName)
        
        var error:NSError? = nil
        let objects =  context?.executeFetchRequest(request, error: &error)
        if let objectList = objects {
            for oneObject in objectList {
                let lineNum = oneObject.valueForKey(lineNumberKey)!.integerValue
                let lineText = oneObject.valueForKey(lineTextKey) as! String
                let textfield = lineFields[lineNum]
                textfield.text = lineText
            }
        } else {
            println("theres was an error")
            // DO whatever error handling is appropriate
        }
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResingActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }
    
    func applicationWillResingActive(notification:NSNotification) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        var error:NSError? = nil
        
        for var i = 0; i < lineFields.count; i++ {
            let textField = lineFields[i]
            let request = NSFetchRequest(entityName: lineEntityName)
            let pred = NSPredicate(format: "%K = %d", lineNumberKey, i)
            request.predicate = pred
            
            let objects = context?.executeFetchRequest(request, error: &error)
            if let objectList = objects {
                var theLine:NSManagedObject! = nil
                if objectList.count > 0 {
                    theLine = objectList[0] as! NSManagedObject
                }else{
                    theLine = NSEntityDescription.insertNewObjectForEntityForName(lineEntityName, inManagedObjectContext: context!) as! NSManagedObject
                }
                theLine.setValue(i, forKey: lineNumberKey)
                theLine.setValue(textField.text, forKey: lineTextKey)
            } else {
                println("There was an error")
                // DO whatever error handling is appropriate
            }
        }
        appDelegate.saveContext()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

