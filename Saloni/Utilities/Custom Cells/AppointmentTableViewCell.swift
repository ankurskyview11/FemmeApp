//
//  AppointmentTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 12/04/21.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var btn_Date: UIButton!
    @IBOutlet weak var btn_Staff: UIButton!
    
    @IBOutlet weak var btn_removeService: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
