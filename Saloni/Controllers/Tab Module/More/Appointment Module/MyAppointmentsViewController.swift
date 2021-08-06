//
//  MyAppointmentsViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 06/04/21.
//

import UIKit

class MyAppointmentsViewController: UIViewController{
    @IBOutlet weak var appointmentList_tableView: UITableView!
    var servicesArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appointmentList_tableView.tableFooterView = UIView()
        servicesArray = [4,3,2,1,5]
        appointmentList_tableView.reloadData()

    }
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

   
}

extension MyAppointmentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesArray.count
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentCellNew", for: indexPath)
        cell.selectionStyle = .none
        
       // let username_lbl: UILabel = cell.viewWithTag(1) as! UILabel
      /* let slideScroller = cell.viewWithTag(8) as! UIScrollView
        let padding:CGFloat = 2
        var offset:CGFloat = 5
        
        
        for index in 0..<servicesArray[indexPath.row] {
            let frame = CGRect(x: 5 + (index * 37), y: 5, width: 35, height: 35 )
            
                let button = UIButton(frame: frame)
              //  button.setTitle("ios", for: .normal)
            button.setImage(UIImage(named: "acne"), for: .normal)
            
            
                slideScroller.addSubview(button)
            offset = offset + CGFloat(padding) + button.frame.size.width
        }
        slideScroller.contentSize = CGSize(width: offset, height: slideScroller.frame.height)*/
        
        let btnAmount : UIButton = cell.viewWithTag(7) as! UIButton
        btnAmount.layer.cornerRadius = 20
        btnAmount.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        let bgView : UIView = cell.viewWithTag(8)!
        bgView.layer.borderWidth = 0.3
        bgView.layer.borderColor = UIColor.darkGray.cgColor
        bgView.addShadow(color: UIColor.lightGray.withAlphaComponent(0.5))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
        let appointmentDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
        appointmentDetailVC.salonName = "Salon Test Name"
        self.navigationController?.pushViewController(appointmentDetailVC, animated: true)
    }
}
