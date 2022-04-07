//
//  Item.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 05.04.2022.
//

import Foundation
import RealmSwift

class Item: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var done: Bool = false
  @objc dynamic var dateCreated: Date?
  
  // parentCategory - Это просто определение обратной зависимости
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
