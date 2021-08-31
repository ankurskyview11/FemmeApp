//
//  LoginWithOTPViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 29/05/21.
//

import UIKit
import CountryPickerView
import AFNetworking
class LoginWithOTPViewController: UIViewController {
    

    @IBOutlet weak var countryPicker: CountryPickerView!
    var currentCountryCode = ""
    var currentCountryName = ""
    @IBOutlet weak var textF_mobileNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryPicker.delegate = self
        countryPicker.dataSource = self
        currentCountryCode = countryPicker.selectedCountry.phoneCode
        currentCountryName = countryPicker.selectedCountry.name
        print("On load country name ==> \(currentCountryName)")
        print("On load country code ==> \(currentCountryCode)")
    }
    

    @IBAction func btnAction_Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAction_GoToOTP_Verification(_ sender: Any) {
//        let otpVerificationVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationViewController") as! OTPVerificationViewController
//        otpVerificationVC.modalPresentationStyle = .fullScreen
//        self.present(otpVerificationVC, animated: true, completion: nil)
        
        if validateMobile(mobileNumber: textF_mobileNumber.text ?? ""){
            print("ok")
            getOTP_Method(phoneNo: textF_mobileNumber.text ?? "")
          

        }
    }
    
    func validateMobile(mobileNumber:String) -> Bool {
        var msg = ""
        
       
      if mobileNumber.isBlank{
            msg = "Please enter mobile number."
            TSMessage.showNotification(in: self,
                                       title: "Alert !",
                                       subtitle: msg,
                                       image: nil,
                                       type: .error,
                                       duration: 1.0,
                                       callback: nil,
                                       buttonTitle: nil,
                                       buttonCallback: nil,
                                       at: .navBarOverlay,
                                       canBeDismissedByUser: true)
            return false
        }
       /// else if ////
        else{
            return true
        }
    }
    
    
    func getOTP_Method(phoneNo:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        let fullMobileNumber = currentCountryCode + phoneNo
        print("Full Mobile Number ==> \(fullMobileNumber)")
        let parameters = ["phone_no":fullMobileNumber,
                          "country_name":currentCountryName]
       
       // let url = "https://salonii.com/api/user/login_with_phone"
     let url = BASE_URL + LOGIN_WITH_PHONE
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
                    let otpVerificationVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationViewController") as! OTPVerificationViewController
                            otpVerificationVC.modalPresentationStyle = .fullScreen
                   
                    otpVerificationVC.getMobileNumber = fullMobileNumber as NSString
                            self.present(otpVerificationVC, animated: true, completion: nil)
                   
                }
                else
                {
                    
                   let msg = dict["msg"] as? String
                    TSMessage.showNotification(in: self,
                                               title: "Alert !",
                                               subtitle: msg,
                                               image: nil,
                                               type: .error,
                                               duration: 1.0,
                                               callback: nil,
                                               buttonTitle: nil,
                                               buttonCallback: nil,
                                               at: .navBarOverlay,
                                               canBeDismissedByUser: true)
                    
                }
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
           
        })
    }
    
    
}
extension LoginWithOTPViewController: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print("country code ==> \(country.code) cPc = \(country.phoneCode) c = \(country.name)")
        currentCountryCode = country.phoneCode
        currentCountryName = country.name
        print("On select country name ==> \(currentCountryName)")
        print("On select country code ==> \(currentCountryCode)")
    }
    
    
}
