//
//  Category.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 05.04.2022.
//

import Foundation
import RealmSwift

class Category: Object {
  @objc dynamic var name: String = ""
  let items = List<Item>() // relationship
}

