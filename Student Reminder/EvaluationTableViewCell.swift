//
//  EvaluationTableViewCell.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 12/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var disciplina: UILabel!
    
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
        data.text = "\(evaluation.date)"
    }
    
}
