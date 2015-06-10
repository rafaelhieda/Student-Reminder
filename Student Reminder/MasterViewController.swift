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
    override func viewDidLoad() {
//        self.manager.insertSubject("Portugues")
        self.view.userInteractionEnabled = true
//        manager.insertSubject("Portugues")
//        manager.selectSubjects()
//        
//        manager.insertEvaluations("PF", evalType: "Prova", evalGrade: 9.8, evalDate: NSDate(), evalSubject: manager.selectSubjects()[8] as! Subjects)
//        manager.selectEvaluations()
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewEvaluation")
    self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    func insertNewEvaluation() {
//        let entityDescription = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext:managedObjectContext!)
//        
//        let evaluation = Evaluations(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        //Nome
        let nameCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! evaluationNameCell
        let newName = nameCell.evaluationName.text
        
        let typeCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! evaluationTypeCell
        let selectedType = typeCell.segmentName()
        

        
        
        //Tipo
        /*
            retrieves the data from subject cell, then returns the actual persisted object in 
            core data. Then adds it into a variable to be persisted in the evaluation entity.
        */
        //subject
        let subjectCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! EvaluationSubjectCell
        let auxRow = subjectCell.evaluationSubjectName.selectedRowInComponent(0)
        let selectedSubject = subjectCell.pickerData[auxRow]
        let subject = manager.selectSubject(selectedSubject)
        
        //date
        let dateCell = self.registerTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! evaluationDateCell
        let newDate = dateCell.datePicker.date
        
        println(newName)
        println(selectedType)
        println(selectedSubject)
        println(newDate)
        
        manager.insertEvaluations(newName, evalType: selectedType, evalGrade: 0.0, evalDate: newDate, evalSubject: subject)
        manager.selectEvaluations()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.registerTableView.endEditing(true)
    }
    
    
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//            self.clearsSelectionOnViewWillAppear = false
//            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
//        }
//        
//
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func insertNewObject(sender: AnyObject) {
//        let context = self.fetchedResultsController.managedObjectContext
//        let entity = self.fetchedResultsController.fetchRequest.entity!
//        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! NSManagedObject
//             
//        // If appropriate, configure the new managed object.
//        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//        newManagedObject.setValue(NSDate(), forKey: "timeStamp")
//             
//        // Save the context.
//        var error: NSError? = nil
//        if !context.save(&error) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //println("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//    }
//
//    // MARK: - Segues
//
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
//
//    // MARK: - Table View
//
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 3
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       
//        return 1
//    }
    
    

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //        self.configureCell(cell, atIndexPath: indexPath)
//        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCellWithIdentifier("evaluationNameCell") as! evaluationNameCell
//            return cell
//        }
//        
//        else if indexPath.section == 1  {
//            let cell = tableView.dequeueReusableCellWithIdentifier("evaluationTypeCell") as! evaluationTypeCell
//            return cell
//        }
//        
//        else if indexPath.section == 2 {
//            let cell  = tableView.dequeueReusableCellWithIdentifier("evaluationDateCell") as! evaluationDateCell
//            return cell
//        }
//        
//        else {
//            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//            return cell
//        }
//        
//
//    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
        }
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

