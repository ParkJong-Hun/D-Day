//
//  AddEventController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/02.
//

import Foundation
import UIKit
import RealmSwift

class AddEventController:UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Async
        let time = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.date_cell!.DateLabel.text = Date().toString()
            self.event_name_cell!.TextField.delegate = self
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.get_category(text: appDelegate!.categoryText)
    }
    
    
    
    
    //MARK: Table
    let cellLists = ["EventName", "Date", "Category"]
    var event_name_cell:EventNameCell?
    var date_cell:DateCell?
    var category_cell:CategoryCell?
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLists[indexPath.row])!
        
        switch cellLists[indexPath.row] {
        case "EventName":
            event_name_cell = cell as? EventNameCell
            break
        case "Date":
            date_cell = cell as? DateCell
            break
        case "Category":
            category_cell = cell as? CategoryCell
            break
        default:
            print("Error")
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == cellLists.firstIndex(where: {$0 == "Date"}) {
            date_picker.isHidden = false
            self.event_name_cell!.TextField.endEditing(true)
        } else {
            date_picker.isHidden = true
        }
        
        if cellLists[indexPath.row] == "Category" {
            guard let controller = storyboard?.instantiateViewController(identifier: "CategoryController") as? CategoryController else { return }
            
            tableView.deselectRow(at: indexPath, animated: false)
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    
    
    
    //MARK: Back Button
    @IBAction func clicked_back_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    //MARK: Complete Button
    @IBAction func clicked_complete_button(_ sender: Any) {
        let new_list = List()
        new_list.name = (event_name_cell?.TextField.text)!
        new_list.day = (date_cell?.DateLabel.text?.toDate())!
        new_list.category = (category_cell?.CategoryLabel.text)!
        if new_list.name == "" {
            new_list.name = "The Event"
        }
        
        try! realm.write {
            realm.add(new_list)
        }
        
        let appDeleagate = UIApplication.shared.delegate as? AppDelegate
        appDeleagate?.categoryText = "None"
        
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    
    
    //MARK: Date Picker
    @IBOutlet weak var date_picker: UIDatePicker!
    @IBAction func changed_date_picker(_ sender: Any) {
        date_cell!.DateLabel.text! = date_picker.date.toString()
        print(date_cell!.DateLabel.text!.toDate())
    }
    
    
    
    
    
    //MARK: Category
    func get_category(text:String) {
        category_cell?.CategoryLabel.text! = text
    }
    
    
    
    
    
    //MARK: Disappear Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.event_name_cell!.TextField.endEditing(true)
   }
}





//MARK:Convert
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM dd, yyyy (E)"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return dateFormatter.string(from: self)
    }
}
extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM dd, yyyy (E)"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return dateFormatter.date(from: self)!
    }
}
