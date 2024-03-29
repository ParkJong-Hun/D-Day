//
//  EditController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit
import RealmSwift

class EditController:UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = realm.objects(List.self)
        
        //Async
        let time = DispatchTime.now() + .milliseconds(700)
        DispatchQueue.main.asyncAfter(deadline: time) {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            self.editDateCell!.DateLabel.text = model[self.data_row].day.toString()
            self.editCategoryCell?.CategoryLabel.text = model[self.data_row].category
            self.editEventNameCell!.TextField.delegate = self
            appDelegate?.categoryText = (self.editCategoryCell?.CategoryLabel.text)!
            appDelegate?.selectedDate = (self.editDateCell?.DateLabel.text?.toDate())!
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Async
        let time = DispatchTime.now() + .milliseconds(300)
        DispatchQueue.main.asyncAfter(deadline: time) {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            self.editDateCell?.DateLabel.text! = appDelegate!.selectedDate.toString()
            self.editCategoryCell?.CategoryLabel.text! = appDelegate?.categoryText ?? "None"
        }
        tableView.reloadData()
    }
    var data_row:Int = 0
    
    
    
    
    
    //MARK: Table
    @IBOutlet weak var tableView: UITableView!
    let cellLists = ["EditEventName", "EditDate", "EditCategory"]
    var editEventNameCell:EditEventNameCell?
    var editDateCell:EditDateCell?
    var editCategoryCell:EditCategoryCell?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = realm.objects(List.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLists[indexPath.row])!
        switch cellLists[indexPath.row] {
        case "EditEventName":
            editEventNameCell = cell as? EditEventNameCell
            editEventNameCell?.TextField.text = model[data_row].name
            break
        case "EditDate":
            editDateCell = cell as? EditDateCell
            editDateCell?.DateLabel.text = model[data_row].day.toString()
            break
        case "EditCategory":
            editCategoryCell = cell as? EditCategoryCell
            editCategoryCell?.CategoryLabel.text = model[data_row].category
            break
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cellLists[indexPath.row] == "EditDate" {
            let controller = (storyboard?.instantiateViewController(identifier: "CalendarController")) as! CalendarController
            let model = realm.objects(List.self)
            controller.selectedDate = model[data_row].day
            self.navigationController?.pushViewController(controller, animated: true)
        } else if cellLists[indexPath.row] == "EditCategory" {
            let controller = (storyboard?.instantiateViewController(identifier: "EditCategoryController"))! as EditCategoryController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    
    
    
    //MARK: Cancel Button
    @IBAction func clicked_cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
    
    
    
    //MARK: Save Button
    @IBAction func clicked_save_button(_ sender: Any) {
        let model = realm.objects(List.self)
        
        try? realm.write {
            model[data_row].name = (editEventNameCell?.TextField.text) ?? "The Event"
            model[data_row].day = (editDateCell!.DateLabel.text?.toDate())!
            model[data_row].category = (editCategoryCell?.CategoryLabel.text)!
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
