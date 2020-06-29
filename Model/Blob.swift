//
//  Blob.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import UIKit

class Blob : NSObject {
    
    var name : String
    var id : String
    var date : Date
    var amount : Double
    var category : Category
    var note : String = ""
    
    init(name: String, id: String, date: Date, amount: Double, cat: Category, note: String) {
        self.name = name
        self.id = id
        self.date = date
        self.amount = amount
        self.category = cat
        self.note = note
        
        
        
        /*let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        dateStr = ("\(month)/\(day)/\(year) \(hour):\(minutes)")*/
        
    }
    
    
    
}
