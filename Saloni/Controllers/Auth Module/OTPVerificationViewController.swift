//
//  OTPVerificationViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 30/05/21.
//

import UIKit
import OTPFieldView
import AFNetworking
class OTPVerificationViewController: UIViewController {

    @IBOutlet weak var otpFieldView: OTPFieldView!
   
    var getMobileNumber : NSString!
    
   var currentOTP = ""
    var allEntered = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupOTPView()
    }
    
    @IBAction func btnAction_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupOTPView() {
        self.otpFieldView.fieldsCount = 4
        self.otpFieldView.fieldBorderWidth = 2
        self.otpFieldView.defaultBorderColor = UIColor.gray
        self.otpFieldView.filledBorderColor = UIColor(named: ACCENT_COLOR) ?? UIColor.yellow
        self.otpFieldView.cursorColor = UIColor(named: ACCENT_COLOR) ?? UIColor.yellow
        self.otpFieldView.displayType = .roundedCorner
        self.otpFieldView.fieldSize = 50
        self.otpFieldView.separatorSpace = 20
        self.otpFieldView.shouldAllowIntermediateEditing = false
        self.otpFieldView.delegate = self
        self.otpFieldView.initializeUI()
    }
    @IBAction func btnAction_VerifyAndLogin(_ sender: Any) {
      
        
        

//        let introVC = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
//        introVC.modalPresentationStyle = .fullScreen
//        self.present(introVC, animated: true, completion: nil)
        
        if allEntered
        {
            verifyOTP_Method(phoneNo: getMobileNumber as String, otp: currentOTP)
        }
        else{
            print("OOPS")
        }
        
    }
    
    
   
    func verifyOTP_Method(phoneNo:String,otp:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
      
        let parameters = ["phone_no":phoneNo,"OTP":otp]
       
       // let url = "https://salonii.com/api/user/otp_verify"
     let url = BASE_URL + OTP_VERIFICATION
        print(url)
       
        let manager = AFHTTPSessionManager()
        
        manager.post(url, parameters: parameters, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
              
        
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    
                    UserDefaults.standard.setValue("YES", forKey: IS_LOGGED_IN)
                    let dataDict = dict["data"] as? NSDictionary
                    print("DATA DICT == > \(dataDict)")
                    UserDefaults.standard.setValue(dataDict?["email"], forKey: "email")
                    UserDefaults.standard.setValue(dataDict?["name"], forKey: "name")
                    UserDefaults.standard.setValue(dataDict?["phone_no"], forKey: "phone_no")
                    UserDefaults.standard.setValue(dataDict?["token"], forKey: "token")
                    UserDefaults.standard.setValue(dataDict?["verified"], forKey: "verified")
                    UserDefaults.standard.setValue(dataDict?["country_name"], forKey: "country_name")
                    UserDefaults.standard.synchronize()
                    let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true, completion: nil)
                   
                }
                else
                {
                    
                    
                    
                }
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
           
        })
    }


}
extension OTPVerificationViewController: OTPFieldViewDelegate{
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print("Has entered all OTP ==> \(hasEnteredAll)")
        allEntered = hasEnteredAll
        return false
    }
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    func enteredOTP(otp: String) {
        print("OTP String == \(otp)")
        self.currentOTP = otp
    }
}
