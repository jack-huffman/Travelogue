//
//  EntryDetailViewController.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/10/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // possible passed Entry for editing
    var entry: Entry?
    
    // IBOutlets
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBtn = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveEntry))
        navigationItem.rightBarButtonItem = saveBtn
        
        if let entry = entry {
            entryImage.image = entry.image ?? UIImage()
            titleTextField.text = entry.title
            datePicker.date = entry.validDate ?? Date()
            contentTextView.text = entry.content ?? ""
        }
    }
    
    @objc func saveEntry() {
        
        if let image = entryImage.image, let title = titleTextField.text, let content = contentTextView.text {
            if entry == nil {
                let newEntry = Entry(title: title, content: content, date: datePicker.date, image: image)
                do {
                    try newEntry?.managedObjectContext?.save()
                } catch {
                    print("Could not save entry")
                }
            } else {
                entry?.update(title: title, content: content, date: datePicker.date, image: image)
                do {
                    try entry?.managedObjectContext?.save()
                } catch {
                    print("Could not update entry")
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
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
