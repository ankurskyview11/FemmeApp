//
//  AppointmentDetailsTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 07/04/21.
//

import UIKit

class AppointmentDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var totalPrice_lbl: UILabel!
    @IBOutlet weak var salonBookingID_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
