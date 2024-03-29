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
        
        tableView.reloadData()
    }
    
    

    
    
    
    //MARK: Table View
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = realm.objects(List.self)
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = realm.objects(List.self)
        let theCell = tableView.dequeueReusableCell(withIdentifier: "Listing") as! ListCell
        theCell.EventNameLabel.text = model[indexPath.row].name
        
        theCell.DDayLabel.text = "D-\(Calendar.current.dateComponents([.day], from: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, to: model[indexPath.row].day).day!)"
        theCell.EventNameLabel.textColor = .black
        theCell.DDayLabel.textColor = .black
        theCell.backgroundColor = .none
        
        if theCell.DDayLabel.text!.contains("--") {
            theCell.DDayLabel.text = "D+\(Calendar.current.dateComponents([.day], from: model[indexPath.row].day, to: Date()).day!)"
            theCell.EventNameLabel.textColor = .darkGray
            theCell.DDayLabel.textColor = .darkGray
            theCell.backgroundColor = .lightGray
        }
        if theCell.DDayLabel.text!.contains("-0") {
            theCell.DDayLabel.text = "D-Day"
            theCell.DDayLabel.textColor = .red
            theCell.DDayLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        }
        
        switch model[indexPath.row].category {
        case "Life":
            theCell.CategoryImage.image = UIImage(systemName: "heart.fill")
            theCell.CategoryImage.tintColor = .systemPink
            break
        case "Work":
            theCell.CategoryImage.image = UIImage(systemName: "bag.fill")
            theCell.CategoryImage.tintColor = .brown
            break
        case "Birthday":
            theCell.CategoryImage.image = UIImage(systemName: "burst.fill")
            theCell.CategoryImage.tintColor = .systemOrange
            break
        default:
            theCell.CategoryImage.image = nil
            break
        }
        return theCell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let list = realm.objects(List.self)
            try! realm.write {
                realm.delete(list[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = storyboard?.instantiateViewController(identifier: "InformationController") as? InformationController else { return }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.navigationController?.pushViewController(controller, animated: true)
        controller.data_row = indexPath.row
    }
    
    
    
    
    
    //MARK: Post Button
    @IBAction func clicked_add_list(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(identifier: "AddEventController") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
