//
//  DepentComponentPickerViewController.swift
//  Pickers
//
//  Created by Edgar on 5/13/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class DepentComponentPickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet var depentPicker: UIPickerView!

    private let stateComponent = 0
    private let zipComponent = 1
    private var stateZips:[String : [String]]!
    private var states:[String]!
    private var zips:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("statedictionary", withExtension: "plist")
        stateZips = NSDictionary(contentsOfURL: plistURL!) as! [String : [String]]
        let allStates = stateZips.keys
        states = sorted(allStates)
        
        let selectedState = states[0]
        zips = stateZips[selectedState]
        
        
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
    
    @IBAction func buttonPressed(sender: UIButton) {
        let stateRow = depentPicker.selectedRowInComponent(stateComponent)
        let zipRow = depentPicker.selectedRowInComponent(zipComponent)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let message = "\(zip) is in \(state)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //MARK:-
    //MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == stateComponent {
            return states.count
        }else{
            return zips.count
        }
    }
    
    // MARK:-
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == stateComponent {
            return states[row]
        }else{
            return zips[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == stateComponent {
            let selectedState = states[row]
            zips = stateZips[selectedState]
            
            depentPicker.reloadComponent(zipComponent)
            depentPicker.selectRow(0, inComponent: zipComponent, animated: true)
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickerWidth = pickerView.bounds.size.width
        if component == zipComponent {
            return pickerWidth/3;
        }else{
            return 2 * pickerWidth/3
        }
    }
    

}
