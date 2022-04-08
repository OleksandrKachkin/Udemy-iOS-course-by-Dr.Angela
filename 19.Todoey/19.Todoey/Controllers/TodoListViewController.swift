//
//  TodoListViewController.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 29.03.2022.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
  
  // global constants
  let realm = try! Realm()
  var todoItems: Results<Item>?
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var selectedCategory: Category? {
    didSet {
      loadItems()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBlue
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    title = selectedCategory?.name
//    searchBar.barTintColor = UIColor(hexString: selectedCategory!.colour)
  }
  
  //MARK: TableView Datasource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems?.count ?? 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
    if let item = todoItems?[indexPath.row] {
      
      cell.textLabel?.text = item.title
      
      if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
        cell.backgroundColor = colour
        cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
      }
      
      cell.accessoryType = item.done ? .checkmark : .none // Ternary operator
    } else {
      cell.textLabel?.text = "No Items Added"
    }
    
    return cell
  }
  
  //MARK: TableView Delegate Methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let item = todoItems?[indexPath.row] {
      do {
        try realm.write({
          item.done = !item.done
        })
        
      } catch {
        print("Error checkmark done status, \(error.localizedDescription)")
      }
    }
    
    tableView.reloadData()
    
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
  
  //MARK: - Add New Items
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
      
      // сохранение newItem в realm
      if let currentCategory = self.selectedCategory {
        do {
          try self.realm.write {
            let newItem = Item()
            newItem.title = textField.text!
            newItem.dateCreated = Date()
            currentCategory.items.append(newItem)
          }
        } catch {
          print("Error saving new items, \(error.localizedDescription)")
        }
      }
      self.tableView.reloadData()
    }
    
    alert.addTextField { (alertTextField) in
      alertTextField.placeholder = "Create new item"
      textField = alertTextField
    }
    
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  //MARK: Model manipulation methods
  
  func loadItems() {
    todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
    tableView.reloadData()
  }
  
  // Delete Item From Swipe
  override func updateModel(at indexPath: IndexPath) {
    super.updateModel(at: indexPath)
    
    if let item = self.todoItems?[indexPath.row] {
      do {
        try realm.write {
          realm.delete(item)
        }
      } catch {
        print("Error Deleting Item \(error.localizedDescription)")
      }
    }
  }
  
  
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
    
    tableView.reloadData()
    
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text?.count == 0 {
      loadItems()
      
      DispatchQueue.main.async {
        searchBar.resignFirstResponder()
      }
    }
  }
  
  
  
}


