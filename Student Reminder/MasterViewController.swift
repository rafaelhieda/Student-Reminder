//
//  MasterViewController.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 02/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var registerTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let manager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    let regManager = RegistryManager.sharedInstance
    
    var detailViewController: DetailViewController? = nil
//    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    override func viewDidLoad() {
//        self.manager.insertSubject("Portugues")
//        self.manager.insertSubject("Ingles")
//        self.manager.insertSubject("Geografia")
        self.view.userInteractionEnabled = true
        manager.selectEvaluations()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        regManager.updateRegistry()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadCellData()
        self.addButton.enabled = self.checkEvaluations()
    }
    
    func checkEvaluations() -> Bool{
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        
        if (subjectCell.pickerData.count != 0){
            return true
        }
        else{
            return false
        }
    }
    
    @IBAction func insertNewEval(sender: AnyObject) {
        let nameAux = self.getNewName()
        let newName = nameAux.newName
        let nameCell = nameAux.nameCell
        
        let newType = self.getNewType()
        let newSubject = self.getNewSubject()
        let newDate = self.getNewDate()
        
        if newName.isEmpty  {
            self.notificateError()
        }
        else{
            self.insertNewEvaluation(newName, newType: newType, newDate: newDate, newSubject: newSubject)
            nameCell.evaluationName.text = ""
            let cloudManager = CloudKitManager.sharedInstance
            cloudManager.fetchEvaluations()
        }
    }
    
    func saveEval(){
        println("Salvar Eval")
    }
    
    func getNewName() -> (newName: String, nameCell: evaluationNameCell){
        //Nome
        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
        return (nameCell.evaluationName.text, nameCell)
    }
    
    func getNewType() -> String{
        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
        return typeCell.segmentName()
    }
    
    func getNewSubject() -> Subjects{
        //Subject
        /*
        retrieves the data from subject cell, then returns the actual persisted object in
        core data. Then adds it into a variable to be persisted in the evaluation entity.
        */
        
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        let auxRow = subjectCell.evaluationSubjectName.selectedRowInComponent(0)
        let selectedSubject = subjectCell.pickerData[auxRow] as! String
        let newSubject = manager.selectSubject(selectedSubject as String)
        
        return newSubject
    }
    
    func getNewDate() -> NSDate{
        //date
        let dateCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! evaluationDateCell
        return dateCell.datePicker.date
    }
    
    func insertNewEvaluation(newName: String, newType: String, newDate: NSDate, newSubject: Subjects) {
        manager.insertEvaluations(newName, evalType: newType, evalDate: newDate, evalSubject: newSubject)
        manager.selectEvaluations()
        notificationManager.reloadNotifications()
    }
    
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
    
    func DismissKeyboard(){
        view.endEditing(true)
    }

    func reloadCellData(){
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        subjectCell.reloadSubjectPicker()
    }
}

