//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Samet Koyuncu on 5.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let localRealm = try! Realm()
    
    // auto-updating container, we don't need '.append()' method anymore
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Shop List"
            textField = alertTextField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            // what will happen once the user clicks the add item button on our uialert
            
            if let newName = textField.text {
                if newName.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    let newCategory = Category()
                    newCategory.name = newName
                    
                    self.save(category: newCategory)
                }
            }
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func save(category: Category) {
        do {
            try localRealm.write({
                localRealm.add(category)
            })
        } catch {
            print("Error saving category, \(error)")
        }
        
        self.tableView.reloadData()
    }

   func loadCategories() {
       categories = localRealm.objects(Category.self)
       
       tableView.reloadData()
    }
}

// MARK: - TableView methods
extension CategoryViewController {
    // TableView  DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let categoryName = categories?[indexPath.row].name ?? "No categories added yet!"
        
        cell.textLabel?.text = categoryName
        
        return cell
    }
    
    // TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
