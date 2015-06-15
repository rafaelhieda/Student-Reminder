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
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    let manager = CoreDataManager.sharedInstance
    var arrayEvaluations: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = CoreDataManager.sharedInstance
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.getEvaluations()
        
        tableView.registerNib(UINib(nibName: "EvaluationTableViewCell", bundle: nil), forCellReuseIdentifier: "EvaluationTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
//    MARK: Pegar dados do CoreData
    
    func getEvaluations(){
        arrayEvaluations = manager.selectEvaluations()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCellWithIdentifier("EvaluationTableViewCell", forIndexPath: indexPath) as! EvaluationTableViewCell
        
        let evaluation = arrayEvaluations[indexPath.row] as! Evaluations
        cell.setEvaluation(evaluation)

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tarefas Agendadas"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEvaluations.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            manager.removeEvaluation(arrayEvaluations[indexPath.row])
            arrayEvaluations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}

