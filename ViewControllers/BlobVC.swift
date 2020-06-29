//
//  BlobVC.swift
//  Budget
//
//  Created by Grace Jiang on 8/14/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit

class BlobVC: UIViewController {
    
    var selectedBlob : Blob?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfo()

    }
    
    
    func updateInfo() {
        nameLabel.text = selectedBlob?.name
        dateLabel.text = Functions.getDateStr(date: (selectedBlob?.date)!)
        amountLabel.text = "$\(selectedBlob!.amount)"
        notesLabel.text = selectedBlob?.note
        categoryImageView.image = selectedBlob?.category.image
    }
    
    
    
    


}
