//
//  TopServicesViewAllViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 07/08/21.
//

import UIKit

class TopServicesViewAllViewController: UIViewController {

    @IBOutlet weak var topServices_CollectionView: UICollectionView!
    var getTopServicesDataArray : [[String:Any]]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension TopServicesViewAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return getTopServicesDataArray.count
           
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
       
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "topServicesAllCell", for: indexPath)
            //cell.backgroundColor = .green
            // Configure the cell
            let serviceImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        serviceImage.contentMode = .scaleAspectFit
            let serviceTitle_lbl : UILabel = cell.viewWithTag(2) as! UILabel
            let places_lbl : UILabel = cell.viewWithTag(3) as! UILabel
            serviceImage.layer.borderWidth = 1
            serviceImage.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
            serviceImage.layer.cornerRadius = 10
            //serviceTitle_lbl.adjustsFontSizeToFitWidth = true
            if getTopServicesDataArray.count > 0 {
                if let imgUrl = getTopServicesDataArray[indexPath.item]["imagepath"]
                {
                    let fileUrl = URL(string: imgUrl as! String)
                    serviceImage.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))

                }
                serviceTitle_lbl.text = "\(getTopServicesDataArray[indexPath.item]["name"] ?? "")"
                places_lbl.text = "\(getTopServicesDataArray[indexPath.item]["places_count"] ?? "") Places"
            }

          
            return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
            print(indexPath.item)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let yourWidth = collectionView.bounds.width/3.0
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.height{
            case 667.0:
                print("iPhone SE")
               // collectionHeight = 140
                return CGSize(width:112, height: 140)
            default:
                print("other models \(UIScreen.main.bounds.size.height)")
                return CGSize(width:120, height: 150)
        
            }
        }
        else{
            return CGSize(width:120, height: 150)
        }
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
