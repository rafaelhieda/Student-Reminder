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
    var arraySubjects: [String] = []
    var arrayEvaluations: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = CoreDataManager.sharedInstance
        manager.insertSubject("Fisica1")
        manager.insertSubject("Engenharia de Software 2")
    }
    
//    MARK: Pegar dados do CoreData
    
    func getSubjects(){
        let subjects = manager.selectSubjects()
        
        for AnyObject in subjects{
            let newSubject = AnyObject as! Subjects
            arraySubjects.append(newSubject.name)
        }
    }

//    func getEvaluations(){
//        let evaluationsArray = manager.selectEvaluations()
//        
//        for AnyObject in evaluationsArray
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arraySubjects.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arraySubjects[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "tableCell")
        cell.textLabel?.text = arrayEvaluations[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

