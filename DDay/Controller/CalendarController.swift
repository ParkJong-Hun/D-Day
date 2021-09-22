//
//  CalendarController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit
import FSCalendar

class CalendarController:UIViewController, FSCalendarDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ddd")
        CalendarView.delegate = self
        CalendarView.scrollEnabled = true
        CalendarView.scrollDirection = .vertical
    }
    @IBOutlet weak var CalendarView: FSCalendar!
    
    
    
    
    
    //MARK: Calendar
    var selectedDate:Date = Date()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: date)!
    }
    
    
    
    
    
    //MARK: OK Button
    @IBAction func clicked_cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clicked_save_button(_ sender: Any) {
        let appDeleagate = UIApplication.shared.delegate as? AppDelegate
        appDeleagate?.selectedDate = selectedDate
        
        self.navigationController?.popViewController(animated: true)
    }
}
