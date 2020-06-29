//
//  CategoryCell.swift
//  Budget
//
//  Created by Grace Jiang on 8/14/19.
//  Copyright © 2019 Grace Jiang. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(c: Category) {
        nameLabel.text = c.name
        amountLabel.text = "$" + String(c.total)
        iconImageView.image = c.image
    }

}
