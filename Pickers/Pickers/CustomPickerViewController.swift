//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Edgar on 5/13/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    private var images:[UIImage]!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var winSoundID: SystemSoundID = 0
    private var cruchSoundID: SystemSoundID = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!,
        ]
        
        winLabel.text = " "
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
    
    
    @IBAction func spin(sender: AnyObject) {
        
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
            
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow++
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            
            if numInRow >= 3 {
                win = true
            }
            
        }
        
        
        if cruchSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &cruchSoundID)
        }
        AudioServicesPlaySystemSound(cruchSoundID)
        
        if win {
            dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64( 0.5 * Double(NSEC_PER_SEC))) ,
                dispatch_get_main_queue(),
                { self.playWithSound()})
        }else{
            dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64( 0.5 * Double(NSEC_PER_SEC))) ,
                dispatch_get_main_queue(),
                { self.showButton() })
        }
        
        button.hidden = true
        winLabel.text = " "
        
    }
    
    // MARK:-
    // MARK Picker Data Source Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    //MARK:-
    // MARK: Picker Delegate Methods
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func showButton() {
        button.hidden = false
    }
    
    func playWithSound(){
        if winSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        
        winLabel.text = "WINNER!"
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, Int64( 1.5 * Double(NSEC_PER_SEC))) , dispatch_get_main_queue(), { self.showButton() } )
        
    }

}
