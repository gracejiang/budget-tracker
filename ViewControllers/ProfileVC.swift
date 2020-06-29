//
//  ProfileVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logoutButton.layer.cornerRadius = 5
        
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
        self.categoryTableView.reloadData()
        
        nameLabel.text = "Hi, " + UserManager.name + "!"
        totalLabel.text = "$" + String(Analysis.sum)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.categoryTableView.dataSource = self
        self.categoryTableView.reloadData()
        
        nameLabel.text = "Hi, " + UserManager.name + "!"
        totalLabel.text = "$" + String(Analysis.sum)
    }
    
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        Analysis.sum = 0
        CategoryManager.resetSums()
        BlobManager.blobs.removeAll()
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryManager.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = categoryTableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell
            let c = CategoryManager.categories[indexPath.row]
            cell!.updateCell(c: c)
            return cell!
    }
    
    
}
