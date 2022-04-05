//
//  CategoryViewController.swift
//  19.Todoey
//
//  Created by Oleksandr Kachkin on 04.04.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
  
  var categories = [Category]()
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
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
      
      // создадим новый NSManagedObject
      let newCategory = Category(context: self.context)
      newCategory.name = textField.text!
      
      self.categories.append(newCategory)
      
      self.saveCategories()
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
    return categories.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    cell.textLabel?.text = categories[indexPath.row].name
    
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
      destinationVC.selectedCategory = categories[indexPath.row]
    }
  }
  
  
  // MARK: - Data Manipulation Methods
  
  // сохранить категорию
  func saveCategories() {
    do {
      try context.save()
    } catch {
      print("Error saving category \(error.localizedDescription)")
    }
    
    tableView.reloadData()
  }
  
  // загрузить категорию
  func loadCategories() {
    
    let request: NSFetchRequest<Category> = Category.fetchRequest()
    
    do {
      categories = try context.fetch(request)
    } catch {
      print("Error loading categories from context \(error.localizedDescription)")
    }
    
    tableView.reloadData()
  }
  
}
