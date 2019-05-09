//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var trip: Trip?

}
