//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//
//

import UIKit
import Foundation
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    
    var entries: [Entry]? {
        return rawEntries?.allObjects as? [Entry]
    }
    
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        self.title = title
    }
}
