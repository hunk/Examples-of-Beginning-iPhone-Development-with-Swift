//
//  FontListViewController.swift
//  Fonts
//
//  Created by Edgar on 8/4/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showFavorites:Bool = false
    private var cellPointSize: CGFloat!
    private let cellIdentifier = "FontName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        
        if showFavorites {
            navigationItem.rightBarButtonItem =  editButtonItem()
        }
    }
    func fontForDIsplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showFavorites {
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? UITableViewCell
        cell?.textLabel?.font = fontForDIsplay(atIndexPath: indexPath)
        cell?.textLabel?.text = fontNames[indexPath.row]
        cell?.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // GET the new view controller using [segue destinationViewController]
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let font  = fontForDIsplay(atIndexPath: indexPath)
        
        
        if segue.identifier == "ShowFontSizes" {
            let sizesVC = segue.destinationViewController as! FontSizesViewController
            sizesVC.title = font.fontName
            sizesVC.font = font
        } else {
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.title = font.fontName
            infoVC.font = font
            infoVC.favorite = contains(FavoritesList.sharedFavoriteList.favorites, font.fontName)
        }

    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showFavorites
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !showFavorites {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delte the row from the data source
            let favorite = fontNames[indexPath.row]
            FavoritesList.sharedFavoriteList.removeFavorite(favorite)
            fontNames = FavoritesList.sharedFavoriteList.favorites
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        FavoritesList.sharedFavoriteList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavoritesList.sharedFavoriteList.favorites
    }
}
