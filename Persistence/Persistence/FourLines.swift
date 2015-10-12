//
//  FourLines.swift
//  Persistence
//
//  Created by Edgar on 8/11/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import Foundation

class FourLines : NSObject, NSCoding, NSCopying {
    var lines: [String]?
    let linesKey = "linesKey"
    
    override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        lines =  aDecoder.decodeObjectForKey(linesKey) as? [String]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let saveLines = lines {
            aCoder.encodeObject(saveLines, forKey: linesKey)
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = FourLines()
        if var linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy{
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
}
