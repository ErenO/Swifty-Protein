//
//  ProteinTableViewCell.swift
//  swifty_protein
//
//  Created by Eren OZDEK on 10/24/17.
//  Copyright © 2017 Eren OZDEK. All rights reserved.
//

import UIKit

class ProteinTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
