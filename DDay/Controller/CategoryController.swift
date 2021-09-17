//
//  CategoryController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/03.
//

import Foundation
import UIKit

class CategoryController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
    //MARK: Table View
    let cellLists = ["Life", "Work", "Birthday"]
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellLists[indexPath.row])!
        return cell
    }
    
    
    
    
    
    //MARK: Complete Button
    @IBAction func clicked_complete_button(_ sender: Any) {
        if let row = tableView.indexPathForSelectedRow?.row {
            print("카테고리 갱신됨")
            
            let appDeleagate = UIApplication.shared.delegate as? AppDelegate
            appDeleagate?.categoryText = cellLists[row]
            
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    //MARK: Back Button
    var addEventController:AddEventController?
    @IBAction func clicked_back_button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
