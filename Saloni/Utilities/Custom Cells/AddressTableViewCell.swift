//
//  AddressTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 07/04/21.
//

import UIKit
import MapKit
class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var salonAddress_lbl: UILabel!
    
    @IBOutlet weak var salonMapDirection: MKMapView!
    
    @IBOutlet weak var salonDirection_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
