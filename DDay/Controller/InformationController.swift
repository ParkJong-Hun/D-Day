//
//  InformationController.swift
//  DDay
//
//  Created by 박종훈 on 2021/09/13.
//

import Foundation
import UIKit

class InformationController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var data_row:Int = 0
    
    
    
    
    
    //MARK: Views
    @IBOutlet weak var EventNameLabel: UILabel!
    @IBOutlet weak var DDayLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CategoryImage: UIImageView!
    
    
    
    
    
    //MARK: OK Button
    @IBAction func clicked_edit_button(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "EditController") as? EditController
        controller?.data_row = data_row
        self.show(controller!, sender: UIButton.self)
    }
}
