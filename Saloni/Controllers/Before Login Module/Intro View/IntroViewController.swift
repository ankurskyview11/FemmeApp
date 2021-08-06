//
//  IntroViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 31/05/21.
//

import UIKit

class IntroViewController: UIViewController {
    
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var bannerImages = [UIImage]()
    var titleArray = [String]()
    var subTitleArray = [String]()
    
    @IBOutlet weak var pageController: CHIPageControlAleppo!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerImages = [UIImage(named: "intromap.jpg")!,
                        UIImage(named: "intro_secondbg.png")!,
                        UIImage(named: "gift_image.png")!,
                        UIImage(named: "intro_fourthbg.png")!]
        btnStart.isHidden = true
        btnNext.isHidden = false
        btnNext.isHidden = false
       
        titleArray = ["Our nearby Partner Spas and Salons","View available time slots for your visit","Avail great discounts and packages","Get expert beauty and health services"]
        subTitleArray = ["My discover the spas and salons nearest to your location with our map feature","You can browse multiple time slots and book according to convenience","We always have exciting offers and beauty treatment packages on Femme app","Femme has a variety of services and beauty treatments for all your needs"]
        titleLbl.adjustsFontSizeToFitWidth = true
        subTitleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.text = titleArray[0]
        subTitleLbl.text = subTitleArray[0]
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageController.tintColor = .lightGray
        pageController.currentPageTintColor = UIColor(named: ACCENT_COLOR)
        pageController.padding = 8
        var yAxis = CGFloat()
        var heightValue = CGFloat()
        
        if UIDevice().userInterfaceIdiom == .phone
                       {
                           switch UIScreen.main.bounds.size.height {
                         
                               
                           case 667:
                               print("iPhone 6,7, 8")
                            yAxis = 0
                               heightValue = 400
                           default:
                               print("iPhone 11")
                            yAxis = 40
                               heightValue = 550

                           }
                       }
        for i in 0..<bannerImages.count {
            let imageView = UIImageView()
            let x = scroller.frame.size.width * CGFloat(i)
            imageView.frame = CGRect(x: x, y: yAxis, width: scroller.frame.width, height: heightValue)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = bannerImages[i]
            scroller.contentSize.width = scroller.frame.size.width * CGFloat(i + 1)
            scroller.addSubview(imageView)
        }
        
    }
    @IBAction func btnAction_Start(_ sender: Any) {
        goToDashBoard()
    }
    @IBAction func btnAction_Next(_ sender: Any) {
        
    }
    @IBAction func btnAction_Skip(_ sender: Any) {
        goToDashBoard()
    }
}
extension IntroViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scroller.contentOffset.x / scroller.bounds.width
    
        let progressInPage = scroller.contentOffset.x - (page * scroller.bounds.width)
        let progress = CGFloat(page) + progressInPage
        pageController.set(progress: Int(progress), animated: true)
        print("PROG == \(progress) == PAGE = \(page) == PAGECONTRL == \(pageController.currentPage)")
        let intPage = Int(page)
        
            titleLbl.text = titleArray[intPage]
            subTitleLbl.text = subTitleArray[intPage]
      
        
        if round(page) == 3{
            btnStart.isHidden = false
            btnNext.isHidden = true
            btnSkip.isHidden = true
        }
        else{
            btnStart.isHidden = true
            btnNext.isHidden = false
            btnSkip.isHidden = false
        }
    }
    
    func goToDashBoard() {
        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
    func goToLoginView(){
        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
           authVC.modalPresentationStyle = .fullScreen
           self.present(authVC, animated: true, completion: nil)
    }
    
}
