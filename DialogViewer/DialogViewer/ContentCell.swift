//
//  ContentCell.swift
//  DialogViewer
//
//  Created by Edgar on 8/4/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    var label: UILabel!
    var text: String! {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
            var newLabelFrame = label.frame
            var newContentFrame = contentView.frame
            let textSize = self.dynamicType.sizeForContentString(newText, forMaxWidth: maxWidth)
            newLabelFrame.size = textSize
            newContentFrame.size = textSize
            label.frame = newLabelFrame
            contentView.frame = newContentFrame
        }
    }
    var maxWidth: CGFloat!
    
    class func sizeForContentString(s: String, forMaxWidth maxWidth: CGFloat) -> CGSize {
        let maxSize = CGSizeMake(maxWidth, 1000)
        let opts =  NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let style =  NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        let atrributes = [
            NSFontAttributeName: self.defaultFont(),
            NSParagraphStyleAttributeName: style
        ]
        
        let string  = s as NSString
        let rect = string.boundingRectWithSize(maxSize, options: opts, attributes: atrributes, context: nil)
        return rect.size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: self.contentView.bounds)
        label.opaque = false
        label.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        label.textColor =  UIColor.blackColor()
        label.textAlignment = .Center
        label.font = self.dynamicType.defaultFont()
        contentView.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func defaultFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
}
