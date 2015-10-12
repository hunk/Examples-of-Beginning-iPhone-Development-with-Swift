//
//  RootViewController.swift
//  Fonts
//
//  Created by Edgar on 8/3/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    private var familyNames: [String]!
    private var cellPointSize: CGFloat!
    private var favoritesList: FavoritesList!
    private let familyCell = "FamilyName"
    private let favoritesCell = "Favorites"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        familyNames =  sorted(UIFont.familyNames() as! [String])
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize =  preferredTableViewFont.pointSize
        favoritesList = FavoritesList.sharedFavoriteList
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            let fontName = UIFont.fontNamesForFamilyName(familyName).first as! String
            return UIFont(name: fontName, size: cellPointSize)
        } else {
            return nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ?  familyNames.count : 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // the font name list
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            return cell
        } else {
            
            // The favorite font
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath) as! UITableViewCell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return indexPath.row == (familyNames.count - 1 ) ? 80 : 44;
        }
        
        return 44
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destanationViewController].
        // Pass the selected Object to the new view controller.
        let  indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as? FontListViewController
        
        if indexPath.section == 0 {
            //Font names list
            let familyName = familyNames[indexPath.row]
            listVC?.fontNames = sorted(UIFont.fontNamesForFamilyName(familyName) as! [String])
            listVC?.navigationItem.title =  familyName
            listVC?.showFavorites =  false
        } else {
            //Favorites list
            listVC?.fontNames = favoritesList.favorites
            listVC?.navigationItem.title = "Favorites"
            listVC?.showFavorites = true
        }
    }
    
}
