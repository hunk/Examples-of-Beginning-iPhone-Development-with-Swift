//
//  FontInfoViewController.swift
//  Fonts
//
//  Created by Edgar on 8/4/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
    var font: UIFont!
    var favorite: Bool =  false
    @IBOutlet weak var fontSampleLabel : UILabel!
    @IBOutlet weak var fontSizeSlider : UISlider!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var favoriteSwitch : UISwitch!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fontSampleLabel.font = font
        fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWWXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizeLabel.text = "\(Int(font.pointSize))"
        favoriteSwitch.on = favorite
    }
    
    @IBAction func slideFontSize(slider: UISlider){
        let newSize = roundf(slider.value)
        fontSampleLabel.font = font.fontWithSize(CGFloat(newSize))
        fontSizeLabel.text = "\(Int(newSize))"
    }
    
    @IBAction func toggleFavorite(sender: UISwitch) {
        let favoriteList = FavoritesList.sharedFavoriteList
        if sender.on {
            favoriteList.addFavorite(font.fontName)
        } else {
            favoriteList.removeFavorite(font.fontName)
        }
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

}
