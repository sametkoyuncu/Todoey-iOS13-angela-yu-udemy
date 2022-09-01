//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // "Swift öğren", "JavaScript pratiklerine devam et", "Akşam etkinliğe katıl"
    var itemArray = [Item]()
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Swift öğren"
        
        let newItem2 = Item()
        newItem2.title = "JavaScript pratiklerine devam et"
        newItem2.isDone = true
        
        let newItem3 = Item()
        newItem3.title = "Akşam etkinliğe katıl"
        
        itemArray.append(newItem1)
        itemArray.append(newItem2)
        itemArray.append(newItem3)
        
        // Do any additional setup after loading the view.
        /*if let items = defaults.array(forKey: "TodoListArray") as? [String] {
             itemArray = items
        }*/
    }
    
    // MARK: - TableView  DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    // MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].isDone = !itemArray[indexPath.row].isDone
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Add new items
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Buy milk.."
            textField = alertTextField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            // what will happen once the user clicks the add item button on our uialert
            
            if let newTitle = textField.text {
                if newTitle.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    
                    let newItem = Item()
                    newItem.title = newTitle
                    // you can trim to
                    self.itemArray.append(newItem)
                    
                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    
                    self.tableView.reloadData()
                }
            }
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    

}

