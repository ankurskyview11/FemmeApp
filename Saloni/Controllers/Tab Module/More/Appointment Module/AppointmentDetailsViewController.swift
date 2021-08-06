//
//  AppointmentDetailsViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 07/04/21.
//

import UIKit
import ParallaxHeader
import SnapKit
class AppointmentDetailsViewController: UIViewController {

    @IBOutlet weak var appointmentDetail_TableView: UITableView!
    var servicesArray = ["Heavenly Facial (60 min)","Acne Facial (60 min)","Hydrocell Facial (60 min)", "Clarity Facial (45 min)"]
    var serviceStaff = ["Agnes","Ryan","Sophia", "Renne"]
    var salonName : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupParallaxHeader()
        
        appointmentDetail_TableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "addressCell")
        appointmentDetail_TableView.register(UINib(nibName: "AppointmentDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "appointmentDetailCell")
        appointmentDetail_TableView.register(UINib(nibName: "ServiceNewTableViewCell", bundle: nil), forCellReuseIdentifier: "serviceCellNew")
  
    }
    
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "SAMPLE")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        //setup blur vibrant view
        imageView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        imageView.blurView.alpha = 0
        
        let bv = UIView()
        bv.backgroundColor = .white
        bv.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        bv.blurView.alpha = 0
        
        
        appointmentDetail_TableView.parallaxHeader.view = imageView
        appointmentDetail_TableView.parallaxHeader.height = 200
        appointmentDetail_TableView.parallaxHeader.minimumHeight = 50
        appointmentDetail_TableView.parallaxHeader.mode = .topFill
        appointmentDetail_TableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
       
        // Label for vibrant text
        let vibrantLabel = UILabel()
        vibrantLabel.text = salonName
        vibrantLabel.font = UIFont.systemFont(ofSize: 30.0)
        vibrantLabel.sizeToFit()
        vibrantLabel.textAlignment = .center
        imageView.blurView.vibrancyContentView?.addSubview(vibrantLabel)
        vibrantLabel.snp.makeConstraints { make in
            make.centerX.equalTo(appointmentDetail_TableView)
            make.top.equalToSuperview().offset(10)
        }

    }
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    

}
extension AppointmentDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return servicesArray.count
        default:
            return 0
        }
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath) as! AddressTableViewCell
            cell.selectionStyle = .none
            cell.salonMapDirection.addShadow(color: .lightGray)
            cell.salonMapDirection.layer.masksToBounds = false
            cell.salonDirection_btn.titleLabel?.adjustsFontSizeToFitWidth = true
           
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentDetailCell", for: indexPath) as! AppointmentDetailsTableViewCell
            cell.selectionStyle = .none
           
           
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCellNew", for: indexPath) as! ServiceNewTableViewCell
            cell.selectionStyle = .none

            cell.servicePriceBtn.layer.cornerRadius = 20
            cell.servicePriceBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
            
            cell.cellBgView.layer.borderWidth = 0.3
            cell.cellBgView.layer.borderColor = UIColor.darkGray.cgColor
            cell.cellBgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
            cell.serviceTimeBGView.layer.borderColor = UIColor.black.cgColor
            cell.serviceTimeBGView.layer.borderWidth = 0.2
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
            cell.selectionStyle = .none
            
           
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180
        case 1:
            return 130
            
        case 2:
            return 170
        default:
          return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
      
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 34)
//        let footerView = UIView(frame:rect)
//        footerView.backgroundColor = .cyan//UIColor(red: 52/255.0, green: 117/255.0, blue: 188/255.0, alpha: 1.0)
//        let sectionTitle = UILabel(frame: rect)
//            sectionTitle.text = "NINJA"
//            sectionTitle.textColor = UIColor.black
//        sectionTitle.font = UIFont.systemFont(ofSize: 17)
//            footerView.addSubview(sectionTitle)
//        return footerView
//        
//        
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return 34
//    }
}
