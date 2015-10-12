//
//  ViewController.swift
//  LocaTest
//
//  Created by Edgar on 5/26/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var mainBtn: UIButton!
    
    var logText: String = "inicio: \n" {
        didSet{
            if logText != oldValue {
                textView.text = logText
            }
        }
    }
    var isStart: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textView.text = logText
        
        manager.delegate = self
        manager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func mainAction(sender: UIButton) {
        
        if isStart {
            isStart = false
            mainBtn.setTitle("Start", forState: UIControlState.Normal)
            manager.stopMonitoringVisits()
            
        }else{
            //inicia
            manager.startMonitoringVisits()
                        NSLog("inicia")
            isStart = true
            mainBtn.setTitle("Stop", forState: UIControlState.Normal)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var str: String
        
        switch (status) {
        case .NotDetermined: str = "NotDetermined"
        case .Restricted: str = "Restricted"
        case .Denied: str = "Denied"
        case .AuthorizedAlways: str = "Authorized"
        case .AuthorizedWhenInUse: str = "AuthorizedWhenInUse"
        }
        
        NSLog("CLAuthorizationStatus: \(str)")
    }
    
    
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        if visit.departureDate.isEqualToDate(NSDate.distantFuture() as! NSDate) {
            // A visit has begun, but not yet ended. User must still be at the place.
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateArrival = dateFormatter.stringFromDate(NSDate())
            let dateArrivalSystem = dateFormatter.stringFromDate(visit.arrivalDate)
            
            logText += "inicio visita \n"
            logText += "time \(dateArrival) \n"
            logText += "system \(dateArrivalSystem) \n"
        } else {
            // The visit is complete, user has left the place.
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateDeparture = dateFormatter.stringFromDate(NSDate())
            let dateDepartureSyetem = dateFormatter.stringFromDate(visit.departureDate)
            
            logText += "termino visita \n"
            logText += "time \(dateDeparture) \n"
            logText += "system \(dateDepartureSyetem) \n"
        }
    }

}

