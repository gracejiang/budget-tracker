//
//  Functions.swift
//  Budget
//
//  Created by Grace Jiang on 8/13/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import UIKit

class Functions : NSObject {
    
    static func alertUser(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func getDate(s: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        let returnDate = formatter.date(from: s)
        
        return returnDate ?? Date()
    }
    
    static func getDateStr(date: Date) -> String {
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        var monthStr = String(month)
        if month < 10 {
            monthStr = "0" + monthStr
        }
        
        var dayStr = String(day)
        if day < 10 {
            dayStr = "0" + dayStr
        }
        
        var hourStr = String(hour)
        if hour < 10 {
            hourStr = "0" + hourStr
        }
        
        var minStr = String(minutes)
        if minutes < 10 {
            minStr = "0" + minStr
        }
        
        return "\(monthStr)/\(dayStr)/\(year) \(hourStr):\(minStr)"
    }
    
}
