//
//  EvaluationEdit.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 21/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class EvaluationEditViewController: UITableViewController {

    @IBOutlet var registerTableView: UITableView!
    
    let manager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    let regManager = RegistryManager.sharedInstance
    let cloudManager = CloudKitManager.sharedInstance
    var oldName = ""
    var oldDate = NSDate()
    var oldSub = ""
    var oldType = ""
    var evaluation: Evaluations!
    
    override func viewDidLoad() {
        self.view.userInteractionEnabled = true
        manager.selectEvaluations()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadCellData()
        self.setOldValues()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
//    MARK: AUX
    
    @IBAction func editEval(sender: AnyObject) {
        let newName = self.getNewName()
        let newDate = self.getNewDate()
        let newType = self.getNewType()
        let newSub = self.getNewSubject()
        
        if(newName != ""){
            self.updateEval(newName, newType: newType, newDate: newDate, newSubject: newSub)
            notificationManager.reloadNotifications()
            self.cloudManager.fetchEvaluations()
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            self.notificateError()
        }
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func reloadCellData(){
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        subjectCell.reloadSubjectPicker()
    }
    
//    MARK: OldValues
    func setOldValues(){
        self.getOldName()
        self.getOldDate()
        self.getOldType()
        self.getOldSubject()
    }
    
    func getOldName(){
        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
        nameCell.evaluationName.text = self.oldName
    }
    
    func getOldDate(){
        let dateCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! evaluationDateCell
        dateCell.datePicker.date = self.oldDate
    }
    
    func getOldType(){
        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
        typeCell.typeSegmentedControl.selectedSegmentIndex = selectOldType()
    }
    
    func selectOldType() -> Int{
        if self.oldType == "Prova" {
            return 0
        }
        else if self.oldType == "Tarefa" {
            return 1
        }
        else{
            return 2
        }
    }
    
    func getOldSubject(){
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        
        let arraySubjects = subjectsName()
        subjectCell.pickerData = arraySubjects.stringType
        subjectCell.evaluationSubjectName.selectRow(arraySubjects.auxRow, inComponent: 0, animated: true)
    }
    
    func subjectsName() ->(stringType:[String], subjectsType:[Subjects], auxRow: Int) {
        var rowReturn = 0
        var subjectsName = [String]()
        var cont = 0
        
        var subjectsArray = manager.selectSubjects() as! [Subjects]
        for sub in subjectsArray {
            let newName = sub.name
            subjectsName.append(newName)
            
            if(newName == oldSub){
                rowReturn = cont
                println("XXXXXXXXXXXXXXXXXXXXXXXXX-XXXXXXXXXXXXXXX \(cont)")
            }
            cont++
        }
        return (subjectsName,subjectsArray, rowReturn)
    }
    
    
//    MARK: NewValues
    func getNewName() -> String{
        //Nome
        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
        return nameCell.evaluationName.text
    }
    
    func getNewSubject() -> Subjects{
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        let auxRow = subjectCell.evaluationSubjectName.selectedRowInComponent(0)
        let selectedSubject = subjectCell.pickerData[auxRow] as! String
        let newSubject = manager.selectSubject(selectedSubject as String)
        
        return newSubject
    }
    
    func getNewType() -> String{
        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
        return typeCell.segmentName()
    }
    
    func getNewDate() -> NSDate{
        //date
        let dateCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! evaluationDateCell
        return dateCell.datePicker.date
    }
    
    func updateEval(newName: String, newType: String, newDate: NSDate, newSubject: Subjects) {
        manager.updateEvaluation(newName, type: newType, date: newDate, subject: newSubject, id: evaluation.objectID)
        notificationManager.reloadNotifications()
    }
    
//    MARK: Notificate
    
    func notificateError(){
        let alertController = UIAlertController(title: "Student Reminder", message: "Campo nome está vazio! Por favor preencha-o! :)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Fechar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func notAvailableView() {
        var notAvaliableView = UIView(frame: self.registerTableView.frame)
        notAvaliableView.backgroundColor = UIColor.blackColor()
        var label = UILabel(frame: CGRectMake(self.registerTableView.frame.midX, self.registerTableView.frame.midY, 50, 50))
        label.text = "testando"
        label.textColor = UIColor.blackColor()
        notAvaliableView.addSubview(label)
    }
}


