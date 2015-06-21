//
//  EvaluationTableViewCell.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 12/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class EvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var disciplina: UILabel!
    
    var auxDate = NSDate()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEvaluation(evaluation: Evaluations){
        disciplina.text = evaluation.subject.name
        tipo.text = evaluation.type
        nome.text = evaluation.name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        data.text = dateFormatter.stringFromDate(evaluation.date)
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        auxDate = evaluation.date
        hora.text = timeFormatter.stringFromDate(auxDate)
    }
}
