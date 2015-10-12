//
//  SearchResultController.swift
//  Sections
//
//  Created by Edgar on 5/26/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import UIKit

class SearchResultController: UITableViewController,UISearchResultsUpdating {

    let sectionsTableIdentifier = "SecionsTableIdentifier"
    var names: [String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    private let longNamesSize = 6
    private let shortNamesButtonIndex = 1
    private let longNamesButtonIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return filteredNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }


    //MARK: UiSearchResultsUpdating Conformance
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        filteredNames.removeAll(keepCapacity: true)
        
        if !searchString.isEmpty {
            let filter:String -> Bool = { name in
                //Filter out long or short names depending on which
                //scope button is selected
                let nameLength = count(name)
                if (buttonIndex == self.shortNamesButtonIndex) && nameLength >= self.longNamesSize ||
                    (buttonIndex == self.longNamesButtonIndex) && nameLength < self.longNamesSize {
                        return false
                }
                
                let range = name.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range != nil
            }
            
            for key in keys {
                let namesForKey = names[key]!
                let matches = namesForKey.filter(filter)
                filteredNames += matches
            }
        
        }
        
        tableView.reloadData()
    }

}
