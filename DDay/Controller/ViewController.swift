//
//  ViewController.swift
//  DDay
//
//  Created by 박종훈 on 2021/08/31.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("리스트 갱신됨")
        tableView.reloadData()
    }
    
    

    
    
    
    //MARK: Table View
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = realm.objects(List.self)
        print(realm.objects(List.self))
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = realm.objects(List.self)
        let theCell = tableView.dequeueReusableCell(withIdentifier: "Listing") as! ListCell
        theCell.EventNameLabel.text = model[indexPath.row].name
        print(model[indexPath.row].day)
        print(Date())
        theCell.DDayLabel.text = "D-\(Calendar.current.dateComponents([.day], from: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!, to: model[indexPath.row].day).day!)"
        if theCell.DDayLabel.text!.contains("--") {
            theCell.DDayLabel.text = "D+\(Calendar.current.dateComponents([.day], from: model[indexPath.row].day, to: Date()).day!)"
            theCell.DDayLabel.textColor = .blue
        }
        if theCell.DDayLabel.text!.contains("-0") {
            theCell.DDayLabel.text = "D-Day"
            theCell.DDayLabel.textColor = .red
        }
        return theCell
    }
    
    
    
    
    
    //MARK: Post Button
    @IBAction func clicked_add_list(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(identifier: "AddEventController") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
