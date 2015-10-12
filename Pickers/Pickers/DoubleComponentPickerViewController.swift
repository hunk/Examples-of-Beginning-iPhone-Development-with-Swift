//
//  DoubleComponentPickerViewController.swift
//  Pickers
//
//  Created by Edgar on 5/13/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class DoubleComponentPickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet var doublePicker: UIPickerView!
    private let fillingComponent = 0
    private let breadComponet = 1
    private let fillingType = ["Ham","Turkey","Peanut Butter","Tuna Salad","Chicken Salad","Roast Beef","Vegamite"]
    private let breadTypes = ["WHite","Whole Wheat","Rye","Sourdough","Saven Grain"]
    
    
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

    @IBAction func buttonPressed(sender: UIButton) {
        let fillingRow = doublePicker.selectedRowInComponent(fillingComponent)
        let breadRow = doublePicker.selectedRowInComponent(breadComponet)
        
        let filling = fillingType[fillingRow]
        let bread = breadTypes[breadRow]
        let message = "Your \(filling) on \(bread) bread will be right up."
        let alert = UIAlertController(title: "Thank you for your order", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Great", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK:-
    //MARK: Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == breadComponet {
            return breadTypes.count
        }else{
            return fillingType.count
        }
    }
    
    //MARK: Pciker Delegate Methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == breadComponet {
            return breadTypes[row]
        }else{
            return fillingType[row]
        }
    }
}
