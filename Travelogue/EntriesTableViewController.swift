//
//  EntriesTableViewController.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {

    var trip: Trip?
    
    // table view outlet
    @IBOutlet var entriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newEntryBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newEntry))
        navigationItem.rightBarButtonItem = newEntryBtn
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        entriesTableView.reloadData()
    }
    
    @objc func newEntry() {
        performSegue(withIdentifier: "newEntry", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = trip?.entries?.count {
            return count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        if let cell = cell as? EntryTableViewCell, let entry = trip?.entries?[indexPath.row] {
            cell.cellTitle.text = entry.title
            cell.cellDate.text = "\(String(describing: entry.validDate))"
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEntryDetail", sender: self)
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EntryDetailViewController, let selectedRow = entriesTableView.indexPathForSelectedRow?.row, let entry = trip?.entries?[selectedRow] {
            destination.entry = entry
        }
    }
 

}
