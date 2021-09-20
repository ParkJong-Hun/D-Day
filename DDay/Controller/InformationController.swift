//
//  InformationController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit
import RealmSwift

class InformationController:UIViewController {
    let realm = try! Realm()
    var data_row:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let model = realm.objects(List.self)
        //Async
        let time = DispatchTime.now() + .milliseconds(300)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.EventNameLabel.text = model[self.data_row].name
            self.DateLabel.text = model[self.data_row].day.toString()
            self.DDayLabel.text = "D-\(Calendar.current.dateComponents([.day], from: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, to: model[self.data_row].day).day!)"
            if self.DDayLabel.text!.contains("--") {
                self.DDayLabel.text = "D+\(Calendar.current.dateComponents([.day], from: model[self.data_row].day, to: Date()).day!)"
            }
            if self.DDayLabel.text!.contains("-0") {
                self.DDayLabel.text = "D-Day"
            }
            switch model[self.data_row].category {
            case "Life":
                self.CategoryImage.image = UIImage(systemName: "heart.fill")
                self.CategoryImage.tintColor = .systemPink
                break
            case "Work":
                self.CategoryImage.image = UIImage(systemName: "bag.fill")
                self.CategoryImage.tintColor = .brown
                break
            case "Birthday":
                self.CategoryImage.image = UIImage(systemName: "burst.fill")
                self.CategoryImage.tintColor = .orange
                break
            default:
                self.CategoryImage.image = nil
                break
            }
        }
    }
    
    
    
    
    //MARK: Views
    @IBOutlet weak var EventNameLabel: UILabel!
    @IBOutlet weak var DDayLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CategoryImage: UIImageView!
    
    
    
    
    
    //MARK: OK Button
    @IBAction func clicked_edit_button(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "EditController") as? EditController
        controller?.data_row = data_row
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
}
