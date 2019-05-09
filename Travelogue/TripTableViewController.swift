//
//  TripTableViewController.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit
import CoreData

class TripTableViewController: UITableViewController {

    var trips = [Trip]()
    
    // table view
    @IBOutlet var tripsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try context.fetch(fetchRequest)
            tripsTableView.reloadData()
        } catch {
            print("Couldn't fetch trips")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        if let cell = cell as? TripTableViewCell {
            cell.cellTitle.text = trips[indexPath.row].title
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let count = trips[indexPath.row].entries?.count else {
                return
            }
            
            if count > 0 {
                let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure you want to delete this record? This cannot be undone.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.deleteTrip(at: indexPath)
                }))
                
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            tripsTableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEntries", sender: self)
    }
    
    func deleteTrip(at indexPath: IndexPath) {
        
        let trip = trips[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return
        }
        context.delete(trip)
        
        do {
            try context.save()
            trips.remove(at: indexPath.row)
            tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Context could not be saved")
            tripsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EntriesTableViewController, let selectedRow = tripsTableView.indexPathForSelectedRow?.row, let entries = trips[selectedRow].entries {
            destination.entries = entries
        }
    }
 

}
