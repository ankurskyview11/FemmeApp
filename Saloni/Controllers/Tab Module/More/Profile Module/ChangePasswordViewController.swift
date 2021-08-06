//
//  ChangePasswordViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 12/11/1442 AH.
//

import UIKit
import AFNetworking
class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var textF_confirmPassword: UITextField!
    @IBOutlet weak var textF_newPassword: UITextField!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var textF_currentPassword: UITextField!
    
    @IBOutlet weak var btnConfirmPassword: UIButton!
    @IBOutlet weak var btnNewPassword: UIButton!
    @IBOutlet weak var btnCurrentPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formView.addShadow(color: .lightGray)
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

        
    }
    
    @IBAction func btnAction_resetPassword(_ sender: Any) {
        
        if validateChangePasswordForm(currentPassword: textF_currentPassword.text ?? "", newPassword: textF_newPassword.text ?? "", confirmPassword: textF_confirmPassword.text ?? ""){
            print("ok")

            resetPassword_Method(currentPassword: textF_currentPassword.text ?? "", newPassword: textF_newPassword.text ?? "", confirmPassword: textF_confirmPassword.text ?? "")

        }
    }
    @IBAction func btnAction_showHide_currentPassword(_ sender: Any) {
        if btnCurrentPassword.isSelected {
            btnCurrentPassword.isSelected = false
            textF_currentPassword.isSecureTextEntry = true
        }
        else{
            btnCurrentPassword.isSelected = true
            textF_currentPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func btnAction_showHide_newPassword(_ sender: Any) {
        if btnNewPassword.isSelected {
            btnNewPassword.isSelected = false
            textF_newPassword.isSecureTextEntry = true
        }
        else{
            btnNewPassword.isSelected = true
            textF_newPassword.isSecureTextEntry = false
        }
    }
    

    @IBAction func btnAction_confirmPassword(_ sender: Any) {
        if btnConfirmPassword.isSelected {
            btnConfirmPassword.isSelected = false
            textF_confirmPassword.isSecureTextEntry = true
        }
        else{
            btnConfirmPassword.isSelected = true
            textF_confirmPassword.isSecureTextEntry = false
        }
    }
    
    
    func validateChangePasswordForm(currentPassword:String,newPassword:String,confirmPassword:String) -> Bool {
        var msg = ""
        
        if currentPassword.isBlank{
            msg = "Please enter current password."
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
        else if newPassword.isBlank{
            msg = "Please enter new password."
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
        else if confirmPassword.isBlank{
            msg = "Please enter confirm password."
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
    func resetPassword_Method(currentPassword:String,newPassword:String,confirmPassword:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
        let headerReq = APP_DELEGATE.getHeaderRequest()
        print(headerReq)
       
        
        let parameters = ["old_password":currentPassword,
                          "password":newPassword,
                          "password_confirmation":confirmPassword]
       
       // let url = "https://salonii.com/api/profile/password/update"
     let url = BASE_URL + CHANGE_PASSWORD
        print(url)
       
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(headerReq, forHTTPHeaderField: "Authorization")
        manager.post(url, parameters: parameters, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
              
        
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    self.logout_Method()
                   
                   
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
    func logout_Method() {
        APP_DELEGATE.clearAllData()
        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        authVC.modalPresentationStyle = .fullScreen
        self.present(authVC, animated: true, completion: nil)
    }
    
}
