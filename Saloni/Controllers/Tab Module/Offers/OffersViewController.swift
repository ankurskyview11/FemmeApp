//
//  OffersViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 02/04/21.
//

import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var offers_TableView: UITableView!
    var offersArray = [UIImage]()
    var offerImageNameArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for i in 1...4 {
            offersArray.append(UIImage(named: "offer\(i).jpeg")!)
            offerImageNameArray.append("offer\(i).jpeg")
        }
        
        
        
        
    }
    
}
extension OffersViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersArray.count
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offerCellNew", for: indexPath)
        cell.selectionStyle = .none
//        let offer_ImageView : UIImageView = cell.viewWithTag(1) as! UIImageView
//        offer_ImageView.image = offersArray[indexPath.row]
//        cell.addShadow(color: .lightGray)
//        cell.layer.cornerRadius = 10
//        let bottomView : UIView = cell.viewWithTag(2)!
//        bottomView.layer.borderWidth = 1
//        bottomView.layer.borderColor = UIColor.gray.cgColor
        
       
        let btnView : UIButton = cell.viewWithTag(5) as! UIButton
        btnView.layer.cornerRadius = 20
        btnView.layer.maskedCorners = [.layerMinXMinYCorner]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
       
        let offerDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "OfferDetailsViewController") as! OfferDetailsViewController
        offerDetailVC.offerName = "20 % Off"
        offerDetailVC.offerImageName = offerImageNameArray[indexPath.row]
        self.navigationController?.pushViewController(offerDetailVC, animated: true)
    }
}
