//
//  TabBarController.swift
//  Saloni
//
//  Created by Ankur Verma on 02/04/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.layer.cornerRadius = 20
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBar.backgroundColor = .clear
        tabBar.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        tabBar.layer.shadowRadius = 40.0
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.6
        tabBar.layer.borderWidth = 0.4
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        
        delegate = self
//        
//        let layer = CAShapeLayer()
//                layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height+30), cornerRadius: (20)).cgPath
//                layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//                layer.shadowColor = UIColor.darkGray.cgColor
//                layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//                layer.shadowRadius = 25.0
//                layer.shadowOpacity = 0.3
//                layer.borderWidth = 1.0
//                layer.opacity = 1.0
//                layer.isHidden = false
//                layer.masksToBounds = false
//                layer.fillColor = UIColor.white.cgColor
//
//                self.tabBar.layer.insertSublayer(layer, at: 0)
        
//        if let items = self.tabBar.items {
//          items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
//        }
//
//        self.tabBar.itemWidth = 30.0
//        self.tabBar.itemPositioning = .centered
        
        
                    
    }
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let indexOfTab = viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        print("IP == \(indexOfTab)")
        if indexOfTab == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ReelsViewController") as? ReelsViewController {
                print("PRE")
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
            return false
        }
        
        return true

    }

}
