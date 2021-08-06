//
//  DiscountTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 09/04/21.
//

import UIKit

class DiscountTableViewCell: UITableViewCell {

    @IBOutlet weak var discountedPrice_lbl: UILabel!
    @IBOutlet weak var discountPercentage_lbl: UILabel!
    @IBOutlet weak var originalPrice_lbl: UILabel!
    
    @IBOutlet weak var offerValidity_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
