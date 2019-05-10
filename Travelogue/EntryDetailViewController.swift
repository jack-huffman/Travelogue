//
//  EntryDetailViewController.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/10/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // possible passed Entry for editing
    var entry: Entry?
    
    let imagePicker = UIImagePickerController()
    
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EntryDetailViewController.entryImageTapped(tapGesture:)))
        entryImage.isUserInteractionEnabled = true
        entryImage.addGestureRecognizer(tapGesture)
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
    
    @objc func entryImageTapped(tapGesture: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Select source", message: "Please select if you would like to take a picture or choose an existing one.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in #selector(EntryDetailViewController.takePicture)}))
        alert.addAction(UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in #selector(EntryDetailViewController.selectPhoto)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)    }
    
    @objc func takePicture() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            alertNotifyUser(message: "Camera could not be opened for this device.")
            return
        }
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    @objc func selectPhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            alertNotifyUser(message: "Photo Library could not be opened.")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        defer {
            picker.dismiss(animated: true)
        }
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            entryImage.image = image
            return
        }
        print("Image couldn't be opened")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        defer {
            picker.dismiss(animated: true)
        }
        print("Cancelled")
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
