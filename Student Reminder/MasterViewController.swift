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
    @IBOutlet var registerTableView: UITableView!
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var subjectCell: EvaluationSubjectCell!
    
    
    override func viewDidLoad() {
//        self.manager.insertSubject("Portugues")
//        self.manager.insertSubject("Ingles")
//        self.manager.insertSubject("Geografia")
        self.view.userInteractionEnabled = true
        manager.selectEvaluations()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewEvaluation")
        self.navigationItem.rightBarButtonItem = addButton
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
        registerTableView.reloadData()
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
        subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        
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
        
        var notificationManager = NotificationManager.sharedInstance
        notificationManager.cancelAllNotifications()
        notificationManager.filterNotifications()
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

//    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
//            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
//        cell.textLabel!.text = object.valueForKey("timeStamp")!.description
//    }
////
////    // MARK: - Fetched results controller
////
//    var fetchedResultsController: NSFetchedResultsController {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//        
//        let fetchRequest = NSFetchRequest()
//        // Edit the entity name as appropriate.
//        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
//        fetchRequest.entity = entity
//        
//        // Set the batch size to a suitable number.
//        fetchRequest.fetchBatchSize = 20
//        
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
//        let sortDescriptors = [sortDescriptor]
//        
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
//        
//    	var error: NSError? = nil
//    	if !_fetchedResultsController!.performFetch(&error) {
//    	     // Replace this implementation with code to handle the error appropriately.
//    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//             //println("Unresolved error \(error), \(error.userInfo)")
//    	     abort()
//    	}
//        
//        return _fetchedResultsController!
//    }    
//    var _fetchedResultsController: NSFetchedResultsController? = nil
//
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.beginUpdates()
//    }
//
//    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//            case .Insert:
//                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//            case .Delete:
//                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
//            default:
//                return
//        }
//    }
//
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        switch type {
//            case .Insert:
//                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//            case .Delete:
//                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//            case .Update:
//                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
//            case .Move:
//                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
//            default:
//                return
//        }
//    }
//
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.tableView.endUpdates()
//    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

