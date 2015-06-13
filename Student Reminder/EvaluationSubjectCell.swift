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
    let manager = CoreDataManager.sharedInstance
    
    var pickerData = []
    override func awakeFromNib() {
       
        super.awakeFromNib()
        self.initialize()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadSubjectPicker", name: "teste", object: nil)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initialize() {
        evaluationSubjectName.dataSource = self
        evaluationSubjectName.delegate = self
        pickerData = subjectsName().stringType
    }
    
    func reloadSubjectPicker() {
        pickerData = subjectsName().stringType
        evaluationSubjectName.reloadAllComponents()
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
        return pickerData[row] as! String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func subjectsName() ->(stringType:[String], subjectsType:[Subjects]) {
        var subjectsName = [String]()
        var subjectsArray = manager.selectSubjects() as! [Subjects]
        for newSubject in subjectsArray {
            subjectsName.append(newSubject.name)
        }
        return (subjectsName,subjectsArray)
    }


}
