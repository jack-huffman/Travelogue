//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    // text field
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        saveBtn.action = #selector(saveTrip)
        self.navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func saveTrip() {
        if let title = titleTextField.text {
            let trip = Trip(title: title)
            
            do {
                try trip?.managedObjectContext?.save()
            } catch {
                print("Could not save trip")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
