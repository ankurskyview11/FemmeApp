//
//  ReelsViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 21/12/1442 AH.
//

import UIKit

class ReelsViewController: UIViewController {

    @IBOutlet weak var reelsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("REELS VIEW")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("REELS VIEW 2")
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reelsCollectionView.reloadData()
    }

    @IBAction func btnAction_close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
extension ReelsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "reelCell", for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height:collectionView.frame.size.height)
 
    }
}
