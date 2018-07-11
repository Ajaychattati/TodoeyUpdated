//
//  ViewController.swift
//  TableApp
//
//  Created by MAC on 09/07/18.
//  Copyright © 2018 Ajay. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Item1"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Item2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Item3"
        itemArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {

            itemArray = items

        }
        
    
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemArray.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return (cell)
    }
    
    // mark table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }
        else {
            itemArray[indexPath.row].done = false
        }
    
       tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
           self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

