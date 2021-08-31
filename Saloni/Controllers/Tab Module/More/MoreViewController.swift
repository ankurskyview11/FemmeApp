//
//  MoreViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 02/04/21.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var moreOption_tableView: UITableView!
    var optionArray = ["My Appointments","Profile","Refer & Earn","Manage Card","Feedback","FAQ","Change Language", "Logout"]
    var optionImageArray = ["appointment","user","gift","settings","feedback","faq","faq","faq"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moreOption_tableView.tableFooterView = UIView()
    }
    

    

}
extension MoreViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        cell.selectionStyle = .none
        
       // let username_lbl: UILabel = cell.viewWithTag(1) as! UILabel
        cell.imageView?.image = UIImage(named: optionImageArray[indexPath.row])
        cell.textLabel?.text = optionArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Gill Sans", size: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        if indexPath.row == 0{
            let myAppointmentVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
            self.navigationController?.pushViewController(myAppointmentVC, animated: true)
        }
        else if indexPath.row == 1{
            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        else if indexPath.row == 3{
            let manageCardVC = self.storyboard?.instantiateViewController(withIdentifier: "ManageCardViewController") as! ManageCardViewController
            self.navigationController?.pushViewController(manageCardVC, animated: true)
        }
        else if indexPath.row == 5
        {
            let faqVC = self.storyboard?.instantiateViewController(withIdentifier: "FaqViewController") as! FaqViewController
            self.navigationController?.pushViewController(faqVC, animated: true)
        }
        else if indexPath.row == 6{
            let languageVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectLanguageViewController") as! SelectLanguageViewController
            //authVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(languageVC, animated: true)
        }
        else if indexPath.row == 7{
            let logutAlert = UIAlertController(title: "Logout!", message: "Do you want to logout ?", preferredStyle: UIAlertController.Style.alert)

            logutAlert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action: UIAlertAction!) in
               // logutAlert.dismiss(animated: true, completion: nil)
            }))

            logutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.logout_Method()
                
            }))

            self.present(logutAlert, animated: true, completion: nil)
        }
       
    }
    
    func logout_Method() {
        APP_DELEGATE.clearAllData()
        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        authVC.modalPresentationStyle = .fullScreen
        self.present(authVC, animated: true, completion: nil)
    }
}
