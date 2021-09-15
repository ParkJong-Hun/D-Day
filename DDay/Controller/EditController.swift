//
//  EditController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit

class EditController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
    
    //MARK: Table
    @IBOutlet weak var tableView: UITableView!
    let cellLists = ["EditEventName", "EditDate", "EditCategory"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLists[indexPath.row])!
        switch cellLists[indexPath.row] {
        case "EditEventName":
            break
        case "EditData":
            break
        case "EditCategory":
            break
        default:
            break
        }
        return cell
    }
}
