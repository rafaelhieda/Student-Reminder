//
//  evaluationDateCell.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 06/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class evaluationDateCell: UITableViewCell {
    
    @IBOutlet weak var datePicker : UIDatePicker!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
