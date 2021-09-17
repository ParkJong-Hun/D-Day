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
    }
    
    
    
    
    
    //MARK: Calendar
    var selectedDate:Date = Date()
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
    }
    
    
    
    
    
    //MARK: OK Button
    @IBAction func clicked_ok_button(_ sender: Any) {
        dismiss(animated: true)
    }
}
