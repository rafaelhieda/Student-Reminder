//
//  RegistryViewController.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 16/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class RegistryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    let manager = CoreDataManager.sharedInstance
    let notificationManger = NotificationManager.sharedInstance
    var arrayRegistry: [NSManagedObject] = []
    var selectedRowIndex: NSIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getRegistry()
        
        tableView.registerNib(UINib(nibName: "RegistryTableViewCell", bundle: nil), forCellReuseIdentifier: "RegistryTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.editButton.enabled = false
        
        self.getRegistry()
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
//    MARK: GetData
    func getRegistry(){
        arrayRegistry = manager.selectEvaluations()
    }
    
//    MARK: TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RegistryTableViewCell",
            forIndexPath: indexPath) as! RegistryTableViewCell
        
        let registry = self.arrayRegistry[indexPath.row] as! Evaluations
        
        cell.setRegistry(registry)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayRegistry.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex.row {
            return 150
        }
        return 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.editButton.enabled = true
        selectedRowIndex = indexPath
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RegistryTableViewCell
        cell.maximize()
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.editButton.enabled = false
        selectedRowIndex = NSIndexPath(forRow: -1, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! RegistryTableViewCell
        cell.minimize()
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
