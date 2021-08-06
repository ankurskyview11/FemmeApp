//
//  ManageCardViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 12/11/1442 AH.
//

import UIKit
import UPCarouselFlowLayout
class ManageCardViewController: UIViewController {

    @IBOutlet weak var customFlowLayout: UPCarouselFlowLayout!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    @IBOutlet weak var btnDefaultCard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customFlowLayout.spacingMode =     UPCarouselFlowLayoutSpacingMode.fixed(spacing: 8)
        btnDefaultCard.addShadow(color: UIColor.lightGray.withAlphaComponent(0.6))
        
    }
    
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        
    }
    @IBAction func btnActiopn_AddNewCard(_ sender: Any) {
        
        let addNewCardVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCardViewController") as! AddCardViewController
        self.navigationController?.pushViewController(addNewCardVC, animated: true)
    }
    
    

}
extension ManageCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-

    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
     
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
   
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: 300, height: 250)
        
    }
}
