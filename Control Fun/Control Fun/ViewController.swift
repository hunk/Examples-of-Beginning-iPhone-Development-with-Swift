//
//  ViewController.swift
//  Control Fun
//
//  Created by Edgar on 3/20/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var sliderLabel: UILabel!
    @IBOutlet var leftSwitch: UISwitch!
    @IBOutlet var rightSwitch: UISwitch!
    @IBOutlet var doSomethingButton: UIButton!
    
    @IBAction func textFieldDoneEditing(sender: UITextField){
        sender.resignFirstResponder()
    }
    
    
    @IBAction func backgroundTap(sender: UIControl){
        nameField.resignFirstResponder()
        numberField.resignFirstResponder()
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let progress = lroundf(sender.value)
        sliderLabel.text = "\(progress)"
        
    }
    
    
    @IBAction func switchChanged(sender: UISwitch) {
        let settings = sender.on
        leftSwitch.setOn(settings, animated: true)
        rightSwitch.setOn(settings, animated: true)
        
    }
    
    
    @IBAction func toogleControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            leftSwitch.hidden = false
            rightSwitch.hidden = false
            doSomethingButton.hidden = true
        }else{
            leftSwitch.hidden = true
            rightSwitch.hidden = true
            doSomethingButton.hidden = false
        }
    }
    
    
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        let controller =  UIAlertController(title: "Are you Sure?", message: nil, preferredStyle: .ActionSheet)
        let yesAction = UIAlertAction(title: "Yes, I´m sure!", style: .Destructive , handler: { action in
            
            let msg = self.nameField.text.isEmpty ? "You can breathe easy, everything went OK." : "You can beath easy, \(self.nameField.text)," + "everything went OK."
            let controller2 = UIAlertController(title: "Something was done", message: msg, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Phew!", style: .Cancel, handler: nil)
            controller2.addAction(cancelAction)
            self.presentViewController(controller2, animated: true, completion: nil)
            
        })
        let noAction = UIAlertAction(title: "No way!", style: .Cancel, handler: nil)
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc =  controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
            ppc.permittedArrowDirections = UIPopoverArrowDirection.Down
        }
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderLabel.text = "50"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

