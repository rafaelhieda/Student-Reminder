//
//  EvaluationSubjectCell.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 10/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class EvaluationSubjectCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var evaluationSubjectName:UIPickerView!

    
    let pickerData = ["Portugues","Matematica","Fisica"]
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initialize() {
        evaluationSubjectName.dataSource = self
        evaluationSubjectName.delegate = self
        
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }


}
