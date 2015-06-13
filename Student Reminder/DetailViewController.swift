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
    var arrayEvaluations: [Evaluations] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = CoreDataManager.sharedInstance
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.getEvaluations()
        
//        manager.insertSubject("Fisica1")
//        manager.insertSubject("Engenharia de Software 2")
        
        tableView.registerNib(UINib(nibName: "EvaluationTableViewCell", bundle: nil), forCellReuseIdentifier: "EvaluationTableViewCell")
    }
    
//    MARK: Pegar dados do CoreData
    
    func getEvaluations(){
        let evals:[NSManagedObject] = manager.selectEvaluations()
        
        for eval in evals{
            arrayEvaluations.append(eval as! Evaluations)
            println("Eval")
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCellWithIdentifier("EvaluationTableViewCell", forIndexPath: indexPath) as! EvaluationTableViewCell
        
        let evaluation = arrayEvaluations[indexPath.row]
        cell.setEvaluation(evaluation)
        
        println("celula")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayEvaluations.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

