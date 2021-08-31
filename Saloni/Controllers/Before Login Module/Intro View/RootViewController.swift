//
//  RootViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 09/08/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("FROM ROOT VIEW")
         if UserDefaults.standard.object(forKey: IS_LOGGED_IN) as! String == "YES"{
            print("LOGGED IN")
            DispatchQueue.main.async() {
            let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            //tabBarVC.modalPresentationStyle = .fullScreen
           // let navigationController = UINavigationController.init(rootViewController: tabBarVC)
            self.present(tabBarVC, animated: true, completion: nil)
              //  self.present(navigationController, animated: true, completion: nil)
            }
         }
         else{
            print("NO LOGGED IN")
         }
   
    }
    
  
  

}
