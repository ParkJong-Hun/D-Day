//
//  List.swift
//  DDay
//
//  Created by 박종훈 on 2021/08/31.
//

import Foundation
import RealmSwift

class List:Object {
    @objc dynamic var name:String = "nil"
    @objc dynamic var day:Date = Date()
    @objc dynamic var category:String = "nil"
}
