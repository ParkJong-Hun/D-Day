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
        CalendarView.delegate = self
        CalendarView.scrollEnabled = true
        CalendarView.scrollDirection = .vertical
    }
    
    
    
    
    
    
    //MARK: Calendar
    @IBOutlet weak var CalendarView: FSCalendar!
    var selectedDate:Date = Date()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //TODO: 언젠가 로케일로 자동으로 타임존 바꾸는걸로 바꿔야지...
        selectedDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: date)!
    }
    
    
    
    
    
    //MARK: Cancel button
    @IBAction func clicked_cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    //MARK: Save button
    @IBAction func clicked_save_button(_ sender: Any) {
        let appDeleagate = UIApplication.shared.delegate as? AppDelegate
        appDeleagate?.selectedDate = selectedDate
        
        self.navigationController?.popViewController(animated: true)
    }
}
