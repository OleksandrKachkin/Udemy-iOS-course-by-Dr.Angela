//
//  CategoryViewController.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 04.04.2022.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
  
  let realm = try! Realm()
  
  var categories: Results<Category>!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadCategories()
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
    
  }
  
  // MARK: - Add New Categories
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Add", style: .default) { (action) in
      
      // создадим новую Категорию
      let newCategory = Category()
      newCategory.name = textField.text!
      
      // сохраняем новую Категорию
      self.save(category: newCategory)
    }
    
    alert.addAction(action)
    
    alert.addTextField { (field) in
      textField = field
      field.placeholder = "Add a new category"
    }
    
    present(alert, animated: true)
  }
  
  // MARK: - TableView DataSource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return categories?.count ?? 1
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
    
    return cell
    
  }

  // MARK: - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // открыть категорию
    performSegue(withIdentifier: "goToItem", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let destinationVC = segue.destination as! TodoListViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
      destinationVC.selectedCategory = categories?[indexPath.row]
    }
  }
  
  
  // MARK: - Data Manipulation Methods
  
  // сохранить категорию
  func save(category: Category) {
    do {
      try realm.write({
        realm.add(category)
      })
    } catch {
      print("Error saving category \(error.localizedDescription)")
    }
    
    tableView.reloadData()
  }
  
  // загрузить категорию
  func loadCategories() {
    
    categories = realm.objects(Category.self)
    
    tableView.reloadData()
  }
  
}
