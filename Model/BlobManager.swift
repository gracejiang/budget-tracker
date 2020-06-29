//
//  BlobManager.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class BlobManager : NSObject {
    
    static var blobs: [String : Blob] = [:]
    static var filteredBlobs: [Blob] = []
    
    static func updateBlobs(callback: @escaping () -> ()) {
        callback()
    }
    
    static func resetAll() {
        blobs = [:]
        filteredBlobs = []
        for c in CategoryManager.categories {
            c.total = 0
            c.blobIds = []
        }
        Analysis.sum = 0
        Analysis.shownSum = 0
    }
    
    static func setUpBlobs(callback: @escaping () -> ()) {
        resetAll()
        let userId = Auth.auth().currentUser!.uid
        let blobsRef = Database.database().reference().child("users").child(userId).child("blobs")
        
        // update online database
        blobsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // observe each child
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                //let key = snap.key
                let value = snap.value as? NSDictionary
                
                let name = value?["name"] as? String ?? ""
                let amount = value?["amount"] as? Double ?? 0.00
                let dateStr = value?["date"] as? String ?? "1/1/2000 00:00"
                let catStr = value?["category"] as? String ?? ""
                let note = value?["note"] as? String ?? ""
                let id = snap.key
                
                let date = Functions.getDate(s: dateStr)
                let blob = Blob(name: name, id: id, date: date, amount: amount, cat: CategoryManager.getCategory(name: catStr), note: note)
                
                // update local database
                // use append and not addBlob cus only updating local database for observed blobs
                blobs[blob.id] = blob // adds to general dict
                filteredBlobs.append(blob) // adds to filtered blobs
                blob.category.addBlob(id: blob.id) // adds blob to category storage
                Analysis.updateAll(b: blob) // updates sum + category total
                Analysis.updateShownSum(amount: blob.amount) // updates shown sum
                
            }
            
            callback()
            
        })
        
    }
    
    static func addBlob(name: String, date: Date, amount: Double, cat: Category, note: String) {
        
        let dateStr = Functions.getDateStr(date: date)

        // update online database
        let ref = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        guard let key = ref.child("blobs").childByAutoId().key else { return }
        
        let blob = ["name": name, "date": dateStr, "amount": amount, "category": cat.name, "note": note] as [String : Any]
        let childUpdates = ["/blobs/\(key)": blob]
        ref.updateChildValues(childUpdates)
        
        // update local database
        let id = key
        let b = Blob(name: name, id: id, date: date, amount: amount, cat: cat, note: note)
        blobs[id] = b
        b.category.addBlob(id: id)
        
        // update sums
        Analysis.updateAll(b: b)
        if CategoryManager.filteredValues[b.category.name]! {
            filteredBlobs.append(b)
            Analysis.updateShownSum(amount: b.amount)
        }
        
    }
    
    static func sortDateAsc(blobs : [Blob]) -> [Blob] {
        return blobs.sorted(by: { $0.date > $1.date })
    }
    
    static func sortDateDesc(blobs : [Blob]) -> [Blob] {
        return blobs.sorted(by: { $0.date < $1.date })
    }
    
    static func filterBlobs(onValues: [String : Bool]) {
        Analysis.shownSum = 0
        filteredBlobs = []
        for (name, on) in onValues {
            if on {
                let ids : [String] = CategoryManager.getCategory(name: name).blobIds
                for id in ids {
                    filteredBlobs.append(BlobManager.blobs[id]!)
                    Analysis.updateShownSum(amount: blobs[id]!.amount)
                }
            }
        }
    }
    
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
