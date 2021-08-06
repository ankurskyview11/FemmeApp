//
//  ServicesTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 07/04/21.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var salonServiceWithStaffName_lbl: UILabel!
    @IBOutlet weak var salonServiceAppointmentTime_lbl: UILabel!
    @IBOutlet weak var salonServiceName_lbl: UILabel!
    @IBOutlet weak var salonServiceImage: UIImageView!
    
    @IBOutlet weak var salonServicePrice_lbl: UILabel!
    
    @IBOutlet weak var salonServiceCancel_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
