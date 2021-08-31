//
//  AroundYouViewAllViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 07/08/21.
//

import UIKit
import StepSlider
class AroundYouViewAllViewController: UIViewController {

    @IBOutlet weak var nearByTableView: UITableView!
    var getNearByDataArray : [[String:Any]]!
    
    @IBOutlet weak var sliderView: StepSlider!
    //  var getDistanceArray : [Double]!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var filterMain_BG: UIView!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var distanceRangeView: UIView!
    @IBOutlet weak var multiplierConst: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnReset.layer.borderWidth = 2
        btnReset.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        distanceRangeView.layer.borderWidth = 1
        distanceRangeView.layer.borderColor = UIColor.lightGray.cgColor
        filterMain_BG.isHidden = true
        filterMain_BG.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        sliderView.labels = ["0km","10km","20km","30km","40km","50km"]
        sliderView.labelFont = UIFont(name: "Gill Sans", size: 10)
        
   
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.height{
            case 667.0:
                print("iPhone SE")
               // collectionHeight = 140
                multiplierConst.constant = CGFloat(80)
            default:
                print("other models \(UIScreen.main.bounds.size.height)")
              //  collectionHeight = 170
               // multiplierConst.constant = CGFloat(80)
        
            }
        }
        
    }

    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAction_closeFilter(_ sender: Any) {
        filterMain_BG.isHidden = true
    }
    @IBAction func btnAction_openFilter(_ sender: Any) {
        filterMain_BG.isHidden = false
    }
    
    @IBAction func btnAction_ResetFilter(_ sender: Any) {
    }
    
    @IBAction func btnAction_SearchByFilter(_ sender: Any) {
    }
}

extension AroundYouViewAllViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNearByDataArray.count
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salonCell", for: indexPath)
        cell.selectionStyle = .none

//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        
        
        let cellBgView : UIView = cell.viewWithTag(101)!
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        cellBgView.layer.cornerRadius = 20
        let bookBtnView : UIButton = cell.viewWithTag(7) as! UIButton
        bookBtnView.layer.cornerRadius = 20
        bookBtnView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]

        let salonImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        let salonName : UILabel = cell.viewWithTag(2) as! UILabel
        let location : UILabel = cell.viewWithTag(3) as! UILabel
        let ratingView: FloatRatingView = cell.viewWithTag(4) as! FloatRatingView
        let homeOption:  UILabel = cell.viewWithTag(5) as! UILabel
        let shopOption:  UILabel = cell.viewWithTag(6) as! UILabel
        
        let distance:  UILabel = cell.viewWithTag(10) as! UILabel
        

        homeOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        shopOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        homeOption.layer.borderWidth = 1
        shopOption.layer.borderWidth = 1
        homeOption.backgroundColor = .white
        shopOption.backgroundColor = .white
        ratingView.delegate = self

        salonName.adjustsFontSizeToFitWidth = true
        location.adjustsFontSizeToFitWidth = true
        salonImage.contentMode = .scaleAspectFill

        if getNearByDataArray.count > 0{
            if let imgUrl = getNearByDataArray[indexPath.row]["image"]
            {
                let fileUrl = URL(string: imgUrl as! String)
                salonImage.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))

            }

            salonName.text = "\(getNearByDataArray[indexPath.row]["name"] ?? "")"
            location.text = "\(getNearByDataArray[indexPath.row]["landmark"] ?? ""), \(getNearByDataArray[indexPath.row]["city"] ?? ""), \(getNearByDataArray[indexPath.item]["state"] ?? ""), \(getNearByDataArray[indexPath.row]["country"] ?? "")"
           // distance.text = "\(String(format: "%.01 fkm", getDistanceArray[indexPath.row]))"
           // ratingView.rating = nearByDataArray[indexPath.row]["ratings"] as! Double
        }
       
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
       
    }
}
extension AroundYouViewAllViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        print("Rating = \(ratingView.rating)")
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        print("Rating F = \(ratingView.rating)")
        
    }
    
}
