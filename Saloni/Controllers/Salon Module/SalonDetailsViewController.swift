//
//  SalonDetailsViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 10/04/21.
//

import UIKit
import ParallaxHeader
import MXSegmentedControl

class SalonDetailsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: MXSegmentedControl!
    @IBOutlet weak var scrollView_Ctrl: UIScrollView!
    private var scrollViewSafeAreaObserver: NSKeyValueObservation!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if #available(iOS 11.0, *) {
                self.scrollViewSafeAreaObserver = self.scrollView_Ctrl.observe(\.safeAreaInsets) { [weak self] (_, _) in
                    self?.scrollViewSafeAreaInsetsDidChange()
                }
            } else {
                self.automaticallyAdjustsScrollViewInsets = false
            }
       // setupParallaxHeader()
        
        segmentedControl.append(title: "SERVICES")
        segmentedControl.append(title: "OFFERS")
        segmentedControl.append(title: "ABOUT")
        segmentedControl.append(title: "REVIEWS")
        segmentedControl.indicatorHeight = 4
        segmentedControl.addTarget(self, action: #selector(changeIndex(segmentedControl:)), for: .valueChanged)
        
    }
    @available(iOS 11.0, *)
    func scrollViewSafeAreaInsetsDidChange() {
        self.scrollView_Ctrl.contentInset.top = -self.scrollView_Ctrl.safeAreaInsets.top
    }

    deinit {
        self.scrollViewSafeAreaObserver?.invalidate()
        self.scrollViewSafeAreaObserver = nil
    }
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "SAMPLE")
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.cornerRadius = 10
        //setup blur vibrant view
        imageView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        imageView.blurView.alpha = 0
        
        let bv = UIView()
        bv.backgroundColor = .white
        bv.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
        bv.blurView.alpha = 0
        
        
        scrollView_Ctrl.parallaxHeader.view = imageView
        scrollView_Ctrl.parallaxHeader.height = 300
        scrollView_Ctrl.parallaxHeader.minimumHeight = 150
        scrollView_Ctrl.parallaxHeader.mode = .topFill
        scrollView_Ctrl.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
           // parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
       
//        // Label for vibrant text
//        let vibrantLabel = UILabel()
//        vibrantLabel.text = salonName
//        vibrantLabel.font = UIFont.systemFont(ofSize: 30.0)
//        vibrantLabel.sizeToFit()
//        vibrantLabel.textAlignment = .center
//        imageView.blurView.vibrancyContentView?.addSubview(vibrantLabel)
//        vibrantLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(appointmentDetail_TableView)
//            make.top.equalToSuperview().offset(10)
//        }

    }
    
    @objc func changeIndex(segmentedControl: MXSegmentedControl) {
//
//        switch segmentedControl.selectedIndex {
//        case 0:
//            segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.4392156863, blue: 0.3803921569, alpha: 1)
//        case 1:
//            segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 0.2044631541, green: 0.7111002803, blue: 0.898917675, alpha: 1)
//        case 2:
//            segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//        default:
//            break
//        }
        
        print("\(segmentedControl.selectedIndex)")
    }
    
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnAction_bookAppointment(_ sender: Any) {
        
        let bookAppointment_VC = self.storyboard?.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        bookAppointment_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(bookAppointment_VC, animated: true)

//       self.present(bookAppointment_VC, animated: true, completion: nil)
        
    }
    
}
