//
//  evaluationTypeCell.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 05/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class evaluationTypeCell: UITableViewCell{
    @IBOutlet weak var typeSegmentedControl:UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func segmentName()->String {
        if self.typeSegmentedControl.selectedSegmentIndex == 0 {
            return "Prova"
        }
        else if self.typeSegmentedControl.selectedSegmentIndex == 1 {
            return "Tarefa"
        }
        else if self.typeSegmentedControl.selectedSegmentIndex == 2 {
            return "Seminario"
        }
        else {
            return ""
        }
    }



}
