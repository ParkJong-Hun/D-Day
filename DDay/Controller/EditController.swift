//
//  EditController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit
import RealmSwift

class EditController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
}
