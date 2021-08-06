//
//  ShopAddressTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 09/04/21.
//

import UIKit

class ShopAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var shopName_lbl: UILabel!
    
    @IBOutlet weak var shopAddress_lbl: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
