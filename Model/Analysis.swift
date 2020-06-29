//
//  Analysis.swift
//  Budget
//
//  Created by Grace Jiang on 8/11/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation

class Analysis : NSObject {

    static var sum : Double = 0.00
    static var shownSum : Double = 0.00
    
    static func updateAll(b: Blob) {
        updateSum(amount: b.amount)
        b.category.updateTotal(amount: b.amount)
    }
    
    static func updateSum(amount: Double) {
        sum += amount
    }
    
    static func updateShownSum(amount: Double) {
        shownSum += amount
    }
    
    
    
    // break down category percentages
    
}
