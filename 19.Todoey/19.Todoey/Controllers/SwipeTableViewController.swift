//
//  SwipeTableViewController.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 07.04.2022.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
  
  var cell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // зададим высоту строки
      tableView.rowHeight = 80.0

    }
  
  // MARK: - TableView Datasource Methods
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell

    cell.delegate = self
    
    return cell
    
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
      
      // handle action by updating  model with deletion
      self.updateModel(at: indexPath)
      
    }
    
    // customize the action appearance
    deleteAction.image = UIImage(systemName: "trash.fill")
    
    return [deleteAction]
  }
  
  
  // MARK: - Delete Data From Swipe
  
  func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
      var options = SwipeOptions()
      options.expansionStyle = .destructive //эффект удаления по одному свайпу
//      options.transitionStyle = .border
      return options
  }
  
  // Update our Data Model
  func updateModel(at indexPath: IndexPath) {
    print("Item deleted from superclass")
  }
}


