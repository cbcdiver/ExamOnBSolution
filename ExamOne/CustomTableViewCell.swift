//
//  CustomTableViewCell.swift
//  ExamOne
//
//  Created by Chris Chadillon on 2017-02-28.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

// Exam:  This is the custom cell for the table view with a Label and an Image

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var theTextView: UILabel!
    @IBOutlet weak var theImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
