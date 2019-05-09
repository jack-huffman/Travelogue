//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//
//

import UIKit
import Foundation
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {

    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            }
            return nil
        }
        set {
            let imageData = newValue!.pngData() as NSData?
            rawImage = imageData ?? nil
        }
    }
    
    var validDate: Date? {
        get {
            return date as Date?
        }
        set {
            date = newValue as NSDate?
        }
    }
    
    convenience init?(title: String, content: String, date: Date?, image: UIImage?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: context)
        self.title = title
        self.content = content
        self.validDate = date
        self.image = image
    }
}
