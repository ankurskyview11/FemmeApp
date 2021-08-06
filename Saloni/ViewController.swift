//
//  ViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 26/03/21.
//

import UIKit
import  BetterSegmentedControl
import AFNetworking
import CountryPickerView
class ViewController: UIViewController {

   
    @IBOutlet weak var loginForm_View: UIView!
    
    @IBOutlet weak var signUpForm_View: UIView!
    
    @IBOutlet weak var signUp_SegmentedControl: BetterSegmentedControl!
    
    
    @IBOutlet weak var login_SegmentedControl: BetterSegmentedControl!
    
    @IBOutlet weak var signUp_innerFormView: UIView!
    @IBOutlet weak var login_innerFormView: UIView!
    
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLoginWithOtp: UIButton!
    
    
    @IBOutlet weak var btnSignUpPassword: UIButton!
    
    @IBOutlet weak var btnLoginPassword: UIButton!
    
   
    @IBOutlet weak var textF_mobile: UITextField!
    
    @IBOutlet weak var textF_name: UITextField!
    @IBOutlet weak var textf_password: UITextField!
    @IBOutlet weak var textF_email: UITextField!
    @IBOutlet weak var countryPicker: CountryPickerView!
    var currentCountryCode = ""
    var currentCountryName = ""
    
    @IBOutlet weak var textF_LoginEmail: UITextField!
    @IBOutlet weak var textF_LoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.view.sendSubviewToBack(VerticalView(frame: self.view.bounds))//(VerticalView(frame: self.view.bounds))
        
        
        
        login_SegmentedControl.layer.borderWidth = 2
        login_SegmentedControl.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        signUp_SegmentedControl.layer.borderWidth = 2
        signUp_SegmentedControl.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        login_SegmentedControl.segments = LabelSegment.segments(withTitles: ["Login","Signup"])
        login_SegmentedControl.addTarget(self, action: #selector(segmentedControlLoginValueChanged(_:)), for: .valueChanged)
        
        signUp_SegmentedControl.segments = LabelSegment.segments(withTitles: ["Login","Signup"])
        signUp_SegmentedControl.addTarget(self, action: #selector(segmentedControlSignUpValueChanged(_:)), for: .valueChanged)
        
        loginForm_View.isHidden = false
        signUpForm_View.isHidden = true
        login_innerFormView.layer.borderWidth = 0.5
        login_innerFormView.layer.borderColor = UIColor.lightGray.cgColor
        signUp_innerFormView.layer.borderWidth = 0.5
        signUp_innerFormView.layer.borderColor = UIColor.lightGray.cgColor
        login_SegmentedControl.setIndex(0)
        signUp_SegmentedControl.setIndex(1)
        login_innerFormView.addShadow(color: UIColor.lightGray)
        signUp_innerFormView.addShadow(color: UIColor.lightGray)
        btnLoginWithOtp.isHidden = false
        btnSignUp.isHidden = true
        
        btnSignUpPassword.isSelected = false
        btnLoginPassword.isSelected = false
        countryPicker.delegate = self
        countryPicker.dataSource = self
        currentCountryCode = countryPicker.selectedCountry.phoneCode
        currentCountryName = countryPicker.selectedCountry.name
        print("On load country name ==> \(currentCountryName)")
        print("On load country code ==> \(currentCountryCode)")
        textF_LoginEmail.text = "harry@gmail.com"
        textF_LoginPassword.text = "123456"
    }

    @IBAction func segmentedControlLoginValueChanged(_ sender: BetterSegmentedControl) {
            print("The login selected index is \(sender.index)")
        
        if sender.index == 0{
            loginForm_View.isHidden = false
            btnLoginWithOtp.isHidden = false
            signUpForm_View.isHidden = true
            btnSignUp.isHidden = true
            
        }
        else{

            loginForm_View.isHidden = true
            btnLoginWithOtp.isHidden = true
            signUpForm_View.isHidden = false
            btnSignUp.isHidden = false
            signUp_SegmentedControl.setIndex(1)
            
        }
        }
    
    @IBAction func segmentedControlSignUpValueChanged(_ sender: BetterSegmentedControl) {
            print("The sign up selected index is \(sender.index)")
        if sender.index == 1{
            loginForm_View.isHidden = true
            btnLoginWithOtp.isHidden = true
            signUpForm_View.isHidden = false
            btnSignUp.isHidden = false
        }
        else{
            

            loginForm_View.isHidden = false
            btnLoginWithOtp.isHidden = false
            signUpForm_View.isHidden = true
            btnSignUp.isHidden = true
            login_SegmentedControl.setIndex(0)
        }
        
        }
    
    @IBAction func btnAction_showHideLoginPassword(_ sender: Any) {
        if btnLoginPassword.isSelected {
            btnLoginPassword.isSelected = false
            textF_LoginPassword.isSecureTextEntry = true
            
        }
        else{
            btnLoginPassword.isSelected = true
            textF_LoginPassword.isSecureTextEntry = false
           
        }
    }
    
    @IBAction func btnAction_showHideSignUpPassword(_ sender: Any) {
        if btnSignUpPassword.isSelected {
            btnSignUpPassword.isSelected = false
            textf_password.isSecureTextEntry = true
        }
        else{
            btnSignUpPassword.isSelected = true
            textf_password.isSecureTextEntry = false
        }
    }
    
    @IBAction func btnAction_Login(_ sender: Any) {
        self.goToHome()//temp
//        if validateLoginForm( email: textF_LoginEmail.text ?? "", password: textF_LoginPassword.text ?? ""){
//            print("ok")
//
//            login_Method(email: textF_LoginEmail.text ?? "", password: textF_LoginPassword.text ?? "")
//
//        }
        
        
    }
    @IBAction func btnAction_SignUp(_ sender: Any) {
        
       
       // registration_Method(name: "", email: "", password: "", phoneNo: "")
        if validateSignUpForm(name: textF_name.text ?? "", email: textF_email.text ?? "", password: textf_password.text ?? "", phoneNo: textF_mobile.text ?? ""){
            print("ok")

            registration_Method(name: textF_name.text ?? "", email: textF_email.text ?? "", password: textf_password.text ?? "", phoneNo: textF_mobile.text ?? "")

        }
    }
    
    @IBAction func btnAction_LoginWithOTP(_ sender: Any) {
        
        let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginWithOTPViewController") as! LoginWithOTPViewController
        otpVC.modalPresentationStyle = .fullScreen
        self.present(otpVC, animated: true, completion: nil)
    }
    
    
    func validateSignUpForm(name:String,email:String,password:String, phoneNo:String) -> Bool {
        var msg = ""
        
        if name.isBlank{
            msg = "Please enter name."
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
        else if email.isBlank{
            msg = "Please enter email."
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
        else if phoneNo.isBlank{
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
        else if !isValidEmail(email:email){
            msg = "Please enter valid email."
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
        
       else if password.isBlank{
            msg = "Please enter password."
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
    
    func validateLoginForm(email:String,password:String) -> Bool {
        var msg = ""
        
       
        if email.isBlank{
            msg = "Please enter email."
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
        else if !isValidEmail(email:email){
            msg = "Please enter valid email."
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
       else if password.isBlank{
            msg = "Please enter password."
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
    
    
    func registration_Method(name:String,email:String,password:String,phoneNo:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        let fullMobileNumbner = currentCountryCode + phoneNo
        print("Full Mobile Number ==> \(fullMobileNumbner)")
        let parameters = ["name":name,
                          "email":email,
                          "phone_no":fullMobileNumbner,
                          "password":password,
                          "country_name":currentCountryName]
       
       // let url = "https://salonii.com/api/user/register"
     let url = BASE_URL + REGISTER_API
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
                    
                    self.login_SegmentedControl.setIndex(0)
                    self.loginForm_View.isHidden = false
                    self.btnLoginWithOtp.isHidden = false
                    self.signUpForm_View.isHidden = true
                    self.btnSignUp.isHidden = true
                   
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
    
    
    func login_Method(email:String,password:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        
       
        let parameters = ["email":email,
                          "password":password]
       
       // let url = "https://salonii.com/api/user/login"
     let url = BASE_URL + LOGIN_API
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
                    UserDefaults.standard.setValue(dataDict?["imageUri"], forKey: "profilePic")
                    UserDefaults.standard.synchronize()
                    self.goToHome()
                    
                    
                 
                   
                }
                else
                {
                    
                    print("SOMETHING WENT WRONG ON LOGIN")
                    
                }
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
           
        })
    }
    
    func goToHome() {
        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
}

extension ViewController: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        print("country code ==> \(country.code) cPc = \(country.phoneCode) c = \(country.name)")
        currentCountryCode = country.phoneCode
        currentCountryName = country.name
        print("On select country name ==> \(currentCountryName)")
        print("On select country code ==> \(currentCountryCode)")
    }
    
    
}
