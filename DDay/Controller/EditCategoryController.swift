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
    
    
    
    
    
    //MARK: OK Button
    @IBAction func clicked_ok_button(_ sender: Any) {
        if let row = tableView.indexPathForSelectedRow?.row {
            print("편집 카테고리 갱신됨")
            
            let appDeleagate = UIApplication.shared.delegate as? AppDelegate
            let index = cellLists[row].index(cellLists[row].startIndex, offsetBy: 4)
            appDeleagate?.categoryText = String(cellLists[row][index...])
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
