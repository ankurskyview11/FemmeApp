//
//  ProfileViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 03/04/21.
//

import UIKit
import AFNetworking
class ProfileViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var image_overlay: UIView!
    
    @IBOutlet weak var userProfileBG_ImageView: UIImageView!
    @IBOutlet weak var userProfile_imageView: UIImageView!
    @IBOutlet weak var userImage_shadowView: UIView!
    @IBOutlet var textField_Array: [UITextField]!
    
    @IBOutlet weak var textView_Address: UITextView!

    @IBOutlet weak var btn_Edit_Save: UIButton!
    var isEdit = false
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var addImage_ImgView: UIImageView!
    
    @IBOutlet weak var btnAddImage: UIButton!
    
    @IBOutlet weak var lbl_username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userProfile_imageView.layer.borderColor = UIColor.white.cgColor
        userProfile_imageView.layer.borderWidth = 6
        userProfile_imageView.layer.cornerRadius = 10
        
        
       userImage_shadowView.layer.cornerRadius = 10
        userImage_shadowView.addShadow(color: UIColor.darkGray)
      
       
        userProfileBG_ImageView.layer.cornerRadius = 10
        userProfileBG_ImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image_overlay.layer.cornerRadius = 10
        image_overlay.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        
        
           for textF in textField_Array
           {
               textF.isUserInteractionEnabled = false
           }
        btn_Edit_Save.setTitle("Edit", for: .normal)
        
        textView_Address.isUserInteractionEnabled = false
        addImage_ImgView.isHidden = true
        btnAddImage.isUserInteractionEnabled = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateProfileData()
        
    }
    
    func updateProfileData() {
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
        lbl_username.text = "\(UserDefaults.standard.object(forKey: "name") ?? "")"
        textField_Array[0].text = "\(UserDefaults.standard.object(forKey: "name") ?? "")"
        textField_Array[1].text = "\(UserDefaults.standard.object(forKey: "email") ?? "")"
        textField_Array[2].text = "\(UserDefaults.standard.object(forKey: "phone_no") ?? "")"
        textView_Address.text = "\(UserDefaults.standard.object(forKey: "address") ?? "")"
        if let imgUrl = UserDefaults.standard.object(forKey: "profilePic")
        {
            let fileUrl = URL(string: imgUrl as! String)
            
            userProfile_imageView.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))
            userProfileBG_ImageView.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))
        }
        
        
        supportingfuction.hideProgressHudInView()
        
    }
    
   func updateUserDefaults(){
    UserDefaults.standard.setValue("\(textField_Array[0].text ?? "")", forKey: "name")
    UserDefaults.standard.synchronize()
    updateProfileData()
    NotificationCenter.default.post(name: Notification.Name(UPDATE_PROFILE), object: nil, userInfo: nil)
    
   }
    
    @IBAction func btnAction_Edit_Save(_ sender: Any) {
         if isEdit
         {
//            for textF in textField_Array
//            {
//                textF.isUserInteractionEnabled = false
//            }
            textField_Array[0].isUserInteractionEnabled = false
            textView_Address.isUserInteractionEnabled = false
            btnAddImage.isUserInteractionEnabled = false
            addImage_ImgView.isHidden = true
            isEdit = false
            btn_Edit_Save.setTitle("Edit", for: .normal)
            
            
           // getUpdatedProfileData(data: textField_Array)
            
            let userData  = getInputsValue(textField_Array, seperatedby: ",")
            print("user data == \(userData)")
            var userDict = [String:String]()
            userDict.updateValue(textField_Array[0].text ?? "", forKey: "name")
            userDict.updateValue(textField_Array[1].text ?? "", forKey: "email")
            userDict.updateValue(textField_Array[2].text ?? "", forKey: "phone")
            sendData(userValue: userDict, address: textView_Address.text)
         }
         else{
//            for textF in textField_Array
//            {
//                textF.isUserInteractionEnabled = true
//            }
            textField_Array[0].isUserInteractionEnabled = true
            textView_Address.isUserInteractionEnabled = true
            btnAddImage.isUserInteractionEnabled = true
            addImage_ImgView.isHidden = false
            isEdit = true
            btn_Edit_Save.setTitle("Save", for: .normal)
            
         }
    }
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    func getInputsValue(_ inputs:[UITextField], seperatedby value: String) -> String {
            return inputs.sorted {$0.tag <  $1.tag}.map {$0.text}.compactMap({$0}).joined(separator: value)
        }
    
    func sendData(userValue:[String:String],address:String)  {
        print(userValue["name"])
        print(userValue["email"])
        print(userValue["phone"])
        print(address)
        updateProfile_Method(name: userValue["name"] ?? "", email: "\(UserDefaults.standard.object(forKey: "email") ?? "")", address: "", phoneNo: "\(UserDefaults.standard.object(forKey: "phone_no") ?? "")")
    }
//    func updateProfilePic_Method()  {
//
//        let imageData: Data = userProfile_imageView.image!.jpegData(compressionQuality: 0.5)!
//
//        let headerReq = APP_DELEGATE.getHeaderRequest()
//        print(headerReq)
//
//                let url = BASE_URL + PROFILE_PIC_UPDATE
//
//               let manager = AFHTTPSessionManager()
//        manager.requestSerializer.setValue(headerReq, forHTTPHeaderField: "Authorization")
//              // manager.requestSerializer.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
//              manager.post(url, parameters: nil, constructingBodyWith: { (data: AFMultipartFormData!) -> Void in
//                   data.appendPart(withFileData: imageData, name: "image", fileName: "photo.jpg", mimeType: "image/jpeg")
//              }, progress: nil, success: {(operation, responseObject) in
//
//
//                   if let dict = responseObject as? NSDictionary {
//                    supportingfuction.hideProgressHudInView()
//                       print(dict)
//
//                    let str = dict["success"] as? Int
//                    if (str == 1) {
//                        print("ok")
//                        self.updateUserDefaults()
//
//                    }
//                       else
//                       {
//                        //  SVProgressHUD.showInfo(withStatus: "Something went wrong! Please try again.")
//
//                       }
//                   }
//               }, failure: {
//                   (operation, error) in
//
//                   print("Error: " + error.localizedDescription)
//
//               })
//
//    }
    func updateProfilePic_Method() {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        let headerReq = APP_DELEGATE.getHeaderRequest()
        print(headerReq)
        let imageData: Data = userProfile_imageView.image!.resized(withPercentage: 0.5)!.jpegData(compressionQuality: 0.5)!
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        let parameters = ["image":strBase64]
       
       // let url = "https://salonii.com/api/profile/update"
     let url = BASE_URL + PROFILE_PIC_UPDATE
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
                    UserDefaults.standard.setValue(dict["data"], forKey: "profilePic")
                    UserDefaults.standard.synchronize()
                   
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

    //name, address, email, phone_no
    func updateProfile_Method(name:String,email:String,address:String,phoneNo:String) {
        
        supportingfuction.showProgressHud("Please Wait...", labelText: "Processing Request!")
    
        let headerReq = APP_DELEGATE.getHeaderRequest()
        print(headerReq)
       
        let parameters = ["name":name,
                          "email":email,
                          "phone_no":phoneNo,
                          "address":address]
       
       // let url = "https://salonii.com/api/profile/update"
     let url = BASE_URL + PROFILE_UPDATE
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
                    self.updateUserDefaults()
                   
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
    @IBAction func btnAction_UpdateUserImage(_ sender: Any) {
      
        let alert = UIAlertController(title: "Femme", message: "Please Select an Option", preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
               print("User click Camera button")
            self.openCamera()
           }))
           
           alert.addAction(UIAlertAction(title: "Photo Library", style: .default , handler:{ (UIAlertAction)in
               print("User click Library button")
            self.openLibrary()
           }))

           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
               print("User click Dismiss button")
           }))

           
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
        
    }
    func openCamera() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.cameraCaptureMode = .photo
        //imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
        
    }
    func openLibrary() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnAction_ChangePassword(_ sender: Any) {
        
        let changePasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate{
        @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
               // imageView_userImage.image = chosenImage
                userProfile_imageView.image = chosenImage
                userProfileBG_ImageView.image = chosenImage
                updateProfilePic_Method()
            }
            
            
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    }
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
