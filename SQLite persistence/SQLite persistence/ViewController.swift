//
//  ViewController.swift
//  SQLite persistence
//
//  Created by Edgar on 8/11/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var database: COpaquePointer = nil
        var result = sqlite3_open(dataFilePath(), &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        
        let createSQL = "CREATE TABLE IF NOT EXISTS FIELDS " +
        " (ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);"
        var errMsg : UnsafeMutablePointer<Int8> = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg)
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to create table")
            return
        }
        
        let query = "SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW"
        var statements: COpaquePointer = nil
        if sqlite3_prepare(database, query, -1, &statements, nil) == SQLITE_OK {
            while sqlite3_step(statements) == SQLITE_ROW {
                let row = Int(sqlite3_column_int(statements, 0))
                let rowData = sqlite3_column_text(statements, 1)
                let fieldValue = String.fromCString(UnsafePointer<CChar>(rowData))
                lineFields[row].text = fieldValue!
            }
            sqlite3_finalize(statements)
        }
        sqlite3_close(database)
        
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResingActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }
    
    func applicationWillResingActive(notification: NSNotification){
        var database: COpaquePointer = nil
        var result = sqlite3_open(dataFilePath(), &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            println("Failed to open database")
            return
        }
        
        for var i = 0; i < lineFields.count; i++ {
            let field = lineFields[i]
            let update = "INSERT OR REPLACE INTO FIELDS (ROW,FIELD_DATA) " +
            "VALUES (?,?)"
            var statement:COpaquePointer = nil
            if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
                let text = field.text
                sqlite3_bind_int(statement, 1, Int32(i))
                sqlite3_bind_text(statement, 2, text, -1, nil)
            }
            if sqlite3_step(statement) != SQLITE_DONE {
                println("Error updating table")
                sqlite3_close(database)
                return
            }
            sqlite3_finalize(statement)
        }
        sqlite3_close(database)
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        return documentsDirectory.stringByAppendingPathComponent("data.sqlite") as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

