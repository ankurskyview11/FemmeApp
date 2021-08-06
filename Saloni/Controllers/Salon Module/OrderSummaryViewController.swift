//
//  OrderSummaryViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 20/04/21.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    

    @IBOutlet weak var byCard_paymentView: UIView!
    @IBOutlet weak var byCash_paymentView: UIView!
    
    @IBOutlet weak var services_TableView: UITableView!
    @IBOutlet weak var orderSummaryView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        byCard_paymentView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        byCard_paymentView.layer.borderWidth = 2
        
        byCash_paymentView.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        byCash_paymentView.layer.borderWidth = 2
        
        services_TableView.tableFooterView = UIView()
        services_TableView.register(UINib(nibName: "ServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "servicesCell")
        
        
    }
    

    @IBAction func btnAction_PayNow(_ sender: Any) {
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}
extension OrderSummaryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 20
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell", for: indexPath) as! ServicesTableViewCell
        cell.selectionStyle = .none
//        cell.bgView.layer.borderWidth = 1
//        cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
//        cell.bgView.layer.cornerRadius = 8
//        cell.btn_Staff.layer.borderWidth = 1
//        cell.btn_Staff.layer.borderColor = UIColor.lightGray.cgColor
//        cell.btn_Date.layer.borderColor = UIColor.lightGray.cgColor
//        cell.btn_Date.layer.borderWidth = 1
//        cell.btn_removeService.isHidden = true
        cell.salonServiceImage.layer.cornerRadius = 8
        cell.salonServiceName_lbl.text = "wwww"
        cell.salonServiceAppointmentTime_lbl.text = "$ 75.0 x 1"
        cell.salonServiceWithStaffName_lbl.text = ""
        cell.salonServicePrice_lbl.isHidden = true
        cell.salonServiceCancel_btn.isHidden = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
       
    }
}
