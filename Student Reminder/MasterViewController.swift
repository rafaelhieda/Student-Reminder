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

    let manager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    @IBOutlet var registerTableView: UITableView!
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var addButton = UIBarButtonItem()
//    var subjectCell: EvaluationSubjectCell!
    
    
    override func viewDidLoad() {
//        self.manager.insertSubject("Portugues")
//        self.manager.insertSubject("Ingles")
//        self.manager.insertSubject("Geografia")
        self.view.userInteractionEnabled = true
        manager.selectEvaluations()
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewEvaluation")
        self.navigationItem.rightBarButtonItem = addButton
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
        self.reloadData()
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
    
    func insertNewEvaluation() {
//        let entityDescription = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext:managedObjectContext!)
//        
//        let evaluation = Evaluations(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        //Nome
        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
        let newName = nameCell.evaluationName.text
        
        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
        let selectedType = typeCell.segmentName()
        //Subject
        /*
            retrieves the data from subject cell, then returns the actual persisted object in 
            core data. Then adds it into a variable to be persisted in the evaluation entity.
        */
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        
        let auxRow = subjectCell.evaluationSubjectName.selectedRowInComponent(0)
        let selectedSubject = subjectCell.pickerData[auxRow] as! String
        let subject = manager.selectSubject(selectedSubject as String)
        
        //date
        let dateCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! evaluationDateCell
        let newDate = dateCell.datePicker.date
        
        if newName.isEmpty  {
            let alertController = UIAlertController(title: "Student Reminder", message: "Campo nome está vazio! Por favor preencha-o! :)", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Fechar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            manager.insertEvaluations(newName, evalType: selectedType, evalGrade: 0.0, evalDate: newDate, evalSubject: subject)
            manager.selectEvaluations()
            nameCell.evaluationName.text = ""
            
        }
        
        notificationManager.reloadNotifications()
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

    func reloadData(){
//        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
//        nameCell.awakeFromNib()
        
//        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
//        typeCell.awakeFromNib()
        
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        subjectCell.reloadSubjectPicker()
    }
}

