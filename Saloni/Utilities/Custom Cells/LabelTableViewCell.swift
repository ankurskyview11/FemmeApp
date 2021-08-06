//
//  LabelTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 09/04/21.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitle_lbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
