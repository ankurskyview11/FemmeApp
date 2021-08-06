//
//  BookAppointmentViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 12/04/21.
//

import UIKit

class BookAppointmentViewController: UIViewController  {

    @IBOutlet weak var appointmentList_TableView: UITableView!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var staffHeader_View: UIView!
    
    @IBOutlet weak var staffList_TableView: UITableView!
    @IBOutlet weak var BG_View: UIView!
   
    @IBOutlet weak var scheduleAppoinmentView: UIView!
    @IBOutlet weak var staffView: UIView!
    @IBOutlet weak var scheduleAppointmentHeader_View: UIView!
    //CALENDER
    fileprivate weak var calendar: FSCalendar!
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
  
    //
    
    @IBOutlet weak var morningScheduleList: TagListView!
    
    @IBOutlet weak var eveningScheduleList: TagListView!
    @IBOutlet weak var afternoonScheduleList: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appointmentList_TableView.tableFooterView = UIView()
        appointmentList_TableView.register(UINib(nibName: "AppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: "appointmentListCell")
        staffHeader_View.layer.cornerRadius = 10
        staffHeader_View.clipsToBounds = true
           staffHeader_View.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        scheduleAppointmentHeader_View.layer.cornerRadius = 10
        scheduleAppointmentHeader_View.clipsToBounds = true
        scheduleAppointmentHeader_View.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        BG_View.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        BG_View.isHidden = true
        staffView.isHidden = true
        scheduleAppoinmentView.isHidden = true
        
        morningScheduleList.delegate = self
        morningScheduleList.textFont = .systemFont(ofSize: 17)
       
        morningScheduleList.addTags(["10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM"])
        morningScheduleList.alignment = .left
        
        
        afternoonScheduleList.delegate = self
        afternoonScheduleList.textFont = .systemFont(ofSize: 16)
       
        afternoonScheduleList.addTags(["12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM","03:00 PM", "03:30 PM"])
        afternoonScheduleList.alignment = .left
        
        
        eveningScheduleList.delegate = self
        eveningScheduleList.textFont = .systemFont(ofSize: 14)
       
        eveningScheduleList.addTags(["04:00 PM", "04:30 PM","05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM"])
        eveningScheduleList.alignment = .left
        
        
    }
    
    @IBAction func btnAction_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func btnAction_CloseStaffListView(_ sender: Any) {
        BG_View.isHidden = true
    }
    @IBAction func btnAction_continue(_ sender: Any) {
        let orderSummary_VC = self.storyboard?.instantiateViewController(withIdentifier: "OrderSummaryViewController") as! OrderSummaryViewController
        orderSummary_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(orderSummary_VC, animated: true)
    }
    @objc func openStaffList() {
        BG_View.isHidden = false
        staffView.isHidden = false
        scheduleAppoinmentView.isHidden = true
    }
    @objc func openScheduler() {
        BG_View.isHidden = false
        staffView.isHidden = true
        scheduleAppoinmentView.isHidden = false
        openCalender()
    }
    
    func openCalender() {

        let calendar = FSCalendar(frame: CGRect(x: 10, y: 5, width: calendarView.frame.size.width - 20, height: 340))

        calendar.backgroundColor = UIColor.white
        calendar.layer.borderWidth = 1
        calendar.layer.borderColor = UIColor.lightGray.cgColor
        calendar.allowsMultipleSelection = false
        
        //calendar.today = calendar.minimumDate
        calendar.layer.cornerRadius = 10
        calendar.dataSource = self
        calendar.delegate = self
        
        //self.view.addSubview(bgView)
        calendarView.addSubview(calendar)
        
    
        self.calendar = calendar
       // btn_SelectDates.addTarget(self, action: #selector(getAndSetDates), for: .touchUpInside)
    }
    
    @IBAction func btnAction_SelectDateAndTime(_ sender: Any) {
        BG_View.isHidden = true
    }
    
    @IBAction func btnAction_closeScheduleView(_ sender: Any) {
        BG_View.isHidden = true
    }
}
extension BookAppointmentViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case appointmentList_TableView:
            return 20
        case staffList_TableView:
            return 10
        default:
            return 0
        }
       
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case appointmentList_TableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentListCell", for: indexPath) as! AppointmentTableViewCell
            cell.selectionStyle = .none
            cell.bgView.layer.borderWidth = 1
            cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
            cell.bgView.layer.cornerRadius = 8
            cell.btn_Staff.layer.borderWidth = 1
            cell.btn_Staff.layer.borderColor = UIColor.lightGray.cgColor
            cell.btn_Date.layer.borderColor = UIColor.lightGray.cgColor
            cell.btn_Date.layer.borderWidth = 1
            cell.btn_Staff.addTarget(self, action: #selector(openStaffList), for: .touchUpInside)
            cell.btn_Date.addTarget(self, action: #selector(openScheduler), for: .touchUpInside)
            return cell
        case staffList_TableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "staffListCell", for: indexPath) 
            cell.selectionStyle = .none
     
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentListCell", for: indexPath) as! AppointmentTableViewCell
            cell.selectionStyle = .none
     
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case appointmentList_TableView:
            return 160
        case staffList_TableView:
            return 80
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
        
       
    }
}
extension BookAppointmentViewController: FSCalendarDataSource, FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            
            print("datesRange contains: \(datesRange!)")
        }
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected:
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
    }
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.month = 1
        comps.month = 0
        comps.day = 1
        let minDate = gregorian.date(byAdding: comps, to: Date())
        return minDate!//Date()
    }
}
extension BookAppointmentViewController: TagListViewDelegate{
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
