//
//  SubjectCell.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 11/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class SubjectCell: UITableViewCell,UITextFieldDelegate {

    
    @IBOutlet weak var subjectNameTF: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.subjectNameTF.autocapitalizationType = UITextAutocapitalizationType.Sentences
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.endEditing(true)
    }

}
