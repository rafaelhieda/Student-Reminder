//
//  evaluationNameCell.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 05/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class evaluationNameCell: UITableViewCell, UITextFieldDelegate{

    var name = ""
    @IBOutlet weak var evaluationName : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.name = evaluationName.text
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
