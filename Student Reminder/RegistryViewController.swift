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
    let notificationManager = NotificationManager.sharedInstance
    let regManager = RegistryManager.sharedInstance
    var arrayRegistry: [NSManagedObject] = []
    var selectedCell: RegistryTableViewCell = RegistryTableViewCell()
    var selectedRowIndex: NSIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getRegistry()
        
        tableView.registerNib(UINib(nibName: "RegistryTableViewCell", bundle: nil), forCellReuseIdentifier: "RegistryTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        regManager.updateRegistry()
        
        self.editButton.enabled = false
        
        self.selectedRowIndex = NSIndexPath(forRow: -1, inSection: 0)
        self.getRegistry()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
//    MARK: GetData
    func getRegistry(){
        arrayRegistry = manager.selectRegistrys()
    }
    
//    MARK: TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RegistryTableViewCell",
            forIndexPath: indexPath) as! RegistryTableViewCell
        
        let registry = self.arrayRegistry[indexPath.row] as! Registry
        
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
        return 80
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            manager.removeRegistry(arrayRegistry[indexPath.row])
            arrayRegistry.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            notificationManager.reloadNotifications()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.editButton.enabled = true
        selectedRowIndex = indexPath
        selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! RegistryTableViewCell
        selectedCell.maximize()
        
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
    
    
    // MARK: - registryEdit button
    @IBAction func editRegistry(sender: AnyObject) {
        let registry = self.arrayRegistry[selectedRowIndex.row] as! Registry
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editView = storyboard.instantiateViewControllerWithIdentifier("regedit") as! RegistryEdit
        
        editView.registry = registry
        
        editView.oldName = selectedCell.nome.text!
        editView.oldGrade = selectedCell.nota.text!
        
        if(selectedCell.status.text == "Entregue"){
            editView.oldStatus = 0
        }
        else{
            editView.oldStatus = 1
        }
        
        self.navigationController?.pushViewController(editView, animated: true)
    }
}
