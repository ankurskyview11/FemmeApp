//
//  SelectLanguageViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 08/10/1442 AH.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var imgView_arabicLang: UIImageView!
    
    @IBOutlet weak var imgView_englishLang: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        languageView.addShadow(color: UIColor.lightGray)

       // btnNext.addShadow(color: UIColor.lightGray)
       
    }
  /*  override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //DispatchQueue.main.async() {
        let defs = UserDefaults.standard
        
        if (defs.object(forKey: IS_LOGGED_IN) != nil) {
   
                   if UserDefaults.standard.object(forKey: IS_LOGGED_IN) as! String == "YES"{
   
                       print("LOGGED IN")
                       let tabBarVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                       tabBarVC.modalPresentationStyle = .fullScreen
                       self.present(tabBarVC, animated: true, completion: nil)
              
                      }
                       else{
                           print("LOGGED OUT")
                        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        authVC.modalPresentationStyle = .fullScreen
                        self.present(authVC, animated: true, completion: nil)
                       }
   
           }
       // }
        
    }*/
    @IBAction func btnAction_SelectArabicLanguage(_ sender: Any) {
        imgView_arabicLang.image = UIImage(named: "selected")
        imgView_englishLang.image = UIImage(named: "unselected")
        //New
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
    }
    @IBAction func btnAction_SelectEnglishLanguage(_ sender: Any) {
        imgView_englishLang.image = UIImage(named: "selected")
        imgView_arabicLang.image = UIImage(named: "unselected")
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    
    @IBAction func btnAction_Next(_ sender: Any) {
        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        authVC.modalPresentationStyle = .fullScreen
        self.present(authVC, animated: true, completion: nil)
        
//        let introVC = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
//        introVC.modalPresentationStyle = .fullScreen
//        self.present(introVC, animated: true, completion: nil)
    }
    
}
