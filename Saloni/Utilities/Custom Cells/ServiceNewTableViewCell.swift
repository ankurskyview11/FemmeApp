//
//  ServiceNewTableViewCell.swift
//  Saloni
//
//  Created by Ankur Verma on 23/12/1442 AH.
//

import UIKit

class ServiceNewTableViewCell: UITableViewCell {
    @IBOutlet weak var serviceTimeBGView: UIView!
    @IBOutlet weak var serviceDate: UILabel!
    @IBOutlet weak var cellBgView: UIView!
    
    @IBOutlet weak var serviceArtistImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var servicePriceBtn: UIButton!
    
    @IBOutlet weak var serviceTimeBtn: UIButton!
    @IBOutlet weak var serviceArtistName: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
