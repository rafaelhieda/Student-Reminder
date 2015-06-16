//
//  RegistryTableViewCell.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 16/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class RegistryTableViewCell: UITableViewCell {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var disciplina: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var nota: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRegistry(registry: Evaluations){
        self.nome.text = registry.name
        self.disciplina.text = registry.subject.name
        self.tipo.text = registry.type
        self.status.text = "Entregue"
        self.nota.text = "5"
        
        self.minimize()
    }
    
    func minimize(){
        self.tipo.hidden = true
        self.status.hidden = true
        self.nota.hidden = true
    }
    
    func maximize(){
        self.tipo.hidden = false
        self.status.hidden = false
        self.nota.hidden = false
    }
    
}
