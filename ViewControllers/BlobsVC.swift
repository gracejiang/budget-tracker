//
//  BlobsVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/8/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit

class BlobsVC:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var blobsTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    static var sortBy : Int = 0
    var values : [Blob] = Array(BlobManager.filteredBlobs)
    
    override func viewWillAppear(_ animated: Bool) {
        values = Array(BlobManager.filteredBlobs)
        self.blobsTableView.dataSource = self
        self.blobsTableView.reloadData()
        totalLabel.text = "Total Spent: $" + String(Analysis.shownSum)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        values = Array(BlobManager.filteredBlobs)
        self.blobsTableView.delegate = self
        self.blobsTableView.dataSource = self
        self.blobsTableView.reloadData()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addTapped() {
        performSegue(withIdentifier: "addBlob", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = blobsTableView.dequeueReusableCell(withIdentifier: "blobCell") as? BlobCell
        
        if (BlobsVC.sortBy == 0) {
            values = BlobManager.sortDateAsc(blobs: BlobManager.filteredBlobs)
        } else if (BlobsVC.sortBy == 1) {
            values = BlobManager.sortDateDesc(blobs: BlobManager.filteredBlobs)
        }
        let b = values[indexPath.row]
        cell!.updateCell(b: b)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBlob", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (segue.identifier == "showBlob") {
            let selectedIndex = blobsTableView.indexPathForSelectedRow?.row
            let selectedBlob = values[selectedIndex!]
            
            if let vc = segue.destination as? BlobVC {
                vc.selectedBlob = selectedBlob
            }
        }
    }
    
    static func updateSortBy(option: Int) {
        sortBy = option
    }
    
    
    
}
