
//
//  DetailViewController.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 02/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myNewTime: UIDatePicker!
    
    @IBOutlet weak var editButton: UIBarButtonItem!

    let pref = NSUserDefaults()
    let manager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    let regManager = RegistryManager.sharedInstance
    var arrayEvaluations: [NSManagedObject] = []
    var selectedCell = EvaluationTableViewCell()
    var selectedIndex = -1
    
//    MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.getEvaluations()
        
        tableView.registerNib(UINib(nibName: "EvaluationTableViewCell", bundle: nil), forCellReuseIdentifier: "EvaluationTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        regManager.updateRegistry()
        self.getEvaluations()
        tableView.reloadData()
        
        self.myNewTime.date = pref.objectForKey("alarm") as! NSDate
        
        self.editButton.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func hourChanged(sender: AnyObject) {
        let myNewDate = myNewTime.date
        
        pref.setObject(myNewDate, forKey: "alarm")
        
        notificationManager.reloadNotifications()
    }
    
//    MARK: Pegar dados do CoreData
    func getEvaluations(){
        arrayEvaluations = manager.selectEvaluations()
    }
    
//    MARK: TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCellWithIdentifier("EvaluationTableViewCell", forIndexPath: indexPath) as! EvaluationTableViewCell
        
        let evaluation = arrayEvaluations[indexPath.row] as! Evaluations
        cell.setEvaluation(evaluation)

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEvaluations.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            manager.removeEvaluation(arrayEvaluations[indexPath.row])
            arrayEvaluations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            notificationManager.reloadNotifications()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.editButton.enabled = true
        self.selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! EvaluationTableViewCell
        self.selectedIndex = indexPath.row
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.editButton.enabled = false
        self.selectedCell = EvaluationTableViewCell()
        self.selectedIndex = -1
    }
    
//    @IBAction func editEval(sender: AnyObject) {
//        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let editView = storyBoard.instantiateViewControllerWithIdentifier("mvc") as! MasterViewController
//        
//        editView.title = "Edição de Tarefa"
//        
//        self.navigationController?.pushViewController(editView, animated: true)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editView = segue.destinationViewController as! EvaluationEditViewController
        
        editView.oldName = selectedCell.nome.text!
        editView.oldDate = selectedCell.auxDate
        editView.oldSub = selectedCell.disciplina.text!
        editView.oldType = selectedCell.tipo.text!
        
        editView.evaluation = arrayEvaluations[selectedIndex] as! Evaluations
    }
}

