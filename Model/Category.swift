//
//  Category.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import UIKit

class Category : NSObject {
    
    var name : String
    var image : UIImage
    var total : Double
    var blobIds : [String] = []
    
    init(name: String, img: UIImage) {
        self.name = name
        self.image = img
        self.total = 0.00
    }
    
    func updateTotal(amount: Double) {
        self.total += amount
    }
    
    func addBlob(id: String) {
        blobIds.append(id)
    }
    
}


