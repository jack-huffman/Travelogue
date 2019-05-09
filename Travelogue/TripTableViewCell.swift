//
//  TripTableViewCell.swift
//  Travelogue
//
//  Created by Jack Huffman on 5/8/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

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
