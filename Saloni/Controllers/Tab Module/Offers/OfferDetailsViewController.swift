//
//  OfferDetailsViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 09/04/21.
//

import UIKit

class OfferDetailsViewController: UIViewController {

    @IBOutlet weak var offerDetail_TableView: UITableView!
    var offerName : String!
    var offerImageName : String!
    var servicesOffered = [String]()
    var packArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupParallaxHeader()

        offerDetail_TableView.register(UINib(nibName: "ShopAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "shopAddressCell")
        offerDetail_TableView.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "labelCell")
        offerDetail_TableView.register(UINib(nibName: "OptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        offerDetail_TableView.register(UINib(nibName: "DiscountTableViewCell", bundle: nil), forCellReuseIdentifier: "dicountCell")
        
        
        servicesOffered = ["Haircut","One step hair color","Highlights","Straight razor shave"]
        packArray = ["Haircut","One step hair color","Highlights","Straight razor shave"]

    }
    
    
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: offerImageName)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        //setup blur vibrant view
        imageView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        imageView.blurView.alpha = 0
        
        let bv = UIView()
        bv.backgroundColor = .white
        bv.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        bv.blurView.alpha = 0
        
        
        offerDetail_TableView.parallaxHeader.view = imageView
        offerDetail_TableView.parallaxHeader.height = 200
        offerDetail_TableView.parallaxHeader.minimumHeight = 50
        offerDetail_TableView.parallaxHeader.mode = .topFill
        offerDetail_TableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
       
        // Label for vibrant text
        let vibrantLabel = UILabel()
        vibrantLabel.text = offerName
        vibrantLabel.font = UIFont.systemFont(ofSize: 30.0)
        vibrantLabel.sizeToFit()
        vibrantLabel.textAlignment = .center
        imageView.blurView.vibrancyContentView?.addSubview(vibrantLabel)
        vibrantLabel.snp.makeConstraints { make in
            make.centerX.equalTo(offerDetail_TableView)
            make.top.equalToSuperview().offset(10)
        }

    }
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    

}
extension OfferDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return servicesOffered.count
        case 3:
            return 1
        case 4:
            return packArray.count
        case 5:
            return 1
        default:
            return 0
        }
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopAddressCell", for: indexPath) as! ShopAddressTableViewCell
            cell.selectionStyle = .none
            cell.shopName_lbl.text = "Salon Shop Name"
            cell.shopAddress_lbl.text = "Salon Shop Address"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell
            cell.selectionStyle = .none
           
            cell.title_lbl.text = "Services Offered"
            cell.subTitle_lbl.text = ""
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionsTableViewCell
            cell.selectionStyle = .none
            
            cell.option_lbl.text = servicesOffered[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell
            cell.selectionStyle = .none
            cell.title_lbl.text = "Terms & Conditions"
            cell.subTitle_lbl.text = "You wiil have to buy complete pack that will include the following"
           
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionsTableViewCell
            cell.selectionStyle = .none
           
            cell.option_lbl.text = packArray[indexPath.row]
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dicountCell", for: indexPath) as! DiscountTableViewCell
            cell.selectionStyle = .none
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$200")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.originalPrice_lbl.attributedText = attributeString

            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopAddressCell", for: indexPath)
            cell.selectionStyle = .none
            
           
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 35
            
        case 2:
            return 30
        case 3:
            return 80
            
        case 4:
            return 30
        case 5:
            return  140
        default:
          return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
      
    }

}
