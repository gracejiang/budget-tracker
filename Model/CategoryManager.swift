//
//  CategoryManager.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import UIKit

class CategoryManager : NSObject {
    
    static var filteredValues: [String : Bool] =
        ["food": true,
         "drinks": true,
         "entertainment": true,
         "shopping": true,
         "transportation": true,
         "misc": true]
    static var categories: [Category] = []
    
    static func addCategory(c: Category) {
        categories.append(c)
    }
    
    static func getCategory(name: String) -> Category {
        for c in categories {
            if (c.name.lowercased() == name.lowercased()) {
                return c
            }
        }
        return Category(name: "nil", img: UIImage())
    }
    
    static func resetSums() {
        for c in categories {
            c.total = 0
        }
    }
    
    static func setUpCategories() {
        let foodImg = UIImage(named: "food")
        let food = Category(name: "food", img: foodImg!)
        addCategory(c: food)
        
        let drinksImg = UIImage(named: "drink")
        let drinks = Category(name: "drinks", img: drinksImg!)
        addCategory(c: drinks)
        
        let entertainmentImg = UIImage(named: "entertainment")
        let entertainment = Category(name: "entertainment", img: entertainmentImg!)
        addCategory(c: entertainment)
        
        let shoppingImg = UIImage(named: "shopping")
        let shopping = Category(name: "shopping", img: shoppingImg!)
        addCategory(c: shopping)
        
        let transportImg = UIImage(named: "transport")
        let transportation = Category(name: "transportation", img: transportImg!)
        addCategory(c: transportation)
        
        let miscImg = UIImage(named: "misc")
        let misc = Category(name: "misc", img: miscImg!)
        addCategory(c: misc)
    }
    
}
