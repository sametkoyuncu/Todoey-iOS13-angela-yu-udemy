//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Samet Koyuncu on 5.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import Combine

class CategoryViewController: SwipeTableViewController {
    
     let localRealm = try! Realm()
    
    // auto-updating container, we don't need '.append()' method anymore
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddCategory", sender: self)
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
    
    // MARK: - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.categories?[indexPath.row] {
            do {
                try self.localRealm.write {
                    self.localRealm.delete(item)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
}

// MARK: - TableView methods
extension CategoryViewController {
    // TableView  DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let categoryName = categories?[indexPath.row].name ?? "No categories added yet!"
        cell.textLabel?.text = categoryName
        
        // right side 40x40px rounded view
        cell.viewWithTag(45)?.layer.cornerRadius = 20
        cell.viewWithTag(45)?.backgroundColor = Functions.getUIColorFromList(for: categories?[indexPath.row].color)
        
        //cell.backgroundColor = Functions.getUIColorFromList(for: categories?[indexPath.row].color)
        
        return cell
    }
    
    // TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        } else if segue.identifier == "goToAddCategory" {
            let destinationVC = segue.destination as! AddCategoryViewController
            
            destinationVC.setCategoryData = { name, color in
                // veriables
                let newCategory = Category()
                newCategory.name = name
                newCategory.color = Functions.getListFromUIColor(for: color)
                
                self.save(category: newCategory)
            }
        }
        
    }
}
