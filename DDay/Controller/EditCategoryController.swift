//
//  EditCategoryController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/19.
//

import Foundation
import UIKit

class EditCategoryController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
    //MARK: Table View
    let cellLists = ["EditLife", "EditWork", "EditBirthday"]
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLists[indexPath.row])!
        return cell
    }
    
    
    
    
    
    //MARK: Cancel button
    @IBAction func clicked_cancel_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    //MARK: Save Button
    @IBAction func clicked_save_button(_ sender: Any) {
        if let row = tableView.indexPathForSelectedRow?.row {
            
            let appDeleagate = UIApplication.shared.delegate as? AppDelegate
            let index = cellLists[row].index(cellLists[row].startIndex, offsetBy: 4)
            appDeleagate?.categoryText = String(cellLists[row][index...])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
