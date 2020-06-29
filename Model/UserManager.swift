//
//  UserManager.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import Foundation
import Firebase

class UserManager : NSObject {
    
    static let ref = Database.database().reference()
    //private static let usersRef = Database.database().reference(withPath: "users")
    var databaseHandle : DatabaseHandle?
    
    static var name : String = ""
    static var email : String = ""
    static var uid : String = ""

    static func setUpCurrUser(callback: @escaping () -> ()) {
        let userId = Auth.auth().currentUser!.uid
        let usersRef = ref.child("users").child(userId)
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            name = value?["name"] as? String ?? ""
            email = value?["email"] as? String ?? ""
            uid = value?["uid"] as? String ?? ""
            
            callback()
        })
    }
    
}
