//
//  MasterViewController.swift
//  FruitSplit
//
//  Created by Chelsea Troy on 4/29/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var fruits = [Fruit]()
    
    let fruitService = FruitService()
    
    var spinner = UIActivityIndicatorView(style: .gray)


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner)
        
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.fruitService.search(for: "fruit", completion: { fruits, error in
            guard let fruits = fruits, error == nil else {
                print(error ?? "unknown error")
                return
            }
            self.fruits = fruits
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        })

    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let fruit = fruits[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.fruit = fruit
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let fruit = fruits[indexPath.row]
        cell.textLabel!.text = fruit.altDescription
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fruits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

