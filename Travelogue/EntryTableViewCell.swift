//
//  EntryTableViewCell.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/10/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    // cell image view
    @IBOutlet weak var cellImageView: UIImageView!
    
    // cell labels
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
