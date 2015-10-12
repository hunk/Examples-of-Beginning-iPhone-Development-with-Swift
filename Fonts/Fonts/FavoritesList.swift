//
//  FavoritesList.swift
//  Fonts
//
//  Created by Edgar on 8/3/15.
//  Copyright (c) 2015 hunk. All rights reserved.
//

import Foundation
import UIKit

class FavoritesList {
    class var sharedFavoriteList :  FavoritesList {
        struct Singleton {
            static let instance =  FavoritesList()
        }
        return Singleton.instance
    }
    
    private(set) var favorites:[String]
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavorites = defaults.objectForKey("favorites") as? [String]
        favorites =  storedFavorites != nil ? storedFavorites! : []
    }
    
    func addFavorite(fontName: String){
        if( !contains(favorites, fontName) ){
            favorites.append(fontName)
            saveFavorites()
        }
    }
    
    func removeFavorite(fontName: String){
        if let index =  find(favorites, fontName) {
            favorites.removeAtIndex(index)
            saveFavorites()
        }
    }
    
    func saveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favorites, forKey: "favorites")
        defaults.synchronize()
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int) {
        let item =  favorites[from]
        favorites.removeAtIndex(from)
        favorites.insert(item, atIndex: to)
        saveFavorites()
    }
}
