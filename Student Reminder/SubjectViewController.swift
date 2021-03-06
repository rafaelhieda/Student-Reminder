//
//  SubjectViewController.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 10/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class SubjectViewController: UITableViewController,UISearchBarDelegate,UITextFieldDelegate{

    let manager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    let regManager = RegistryManager.sharedInstance
    var subjectsArray:[Subjects]!
    var subjectNameArray:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewWillAppear(animated: Bool) {
        regManager.updateRegistry()
        subjectsArray = subjectsName().subjectsType
        subjectNameArray = subjectsName().stringType
    }

// MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return manager.selectSubjects().count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("textFieldCell", forIndexPath: indexPath) as! UITableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("subjectCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = subjectNameArray[indexPath.row]
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Nome da Disciplina"
        }
        else {
            return "Disciplinas Cadastradas"
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        manager.removeSubject(subjectsArray[indexPath.row])
        self.subjectsArray.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        notificationManager.reloadNotifications()
    }

    @IBAction func saveSubject(sender: AnyObject) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! SubjectCell
        if cell.subjectNameTF.text.isEmpty {
            self.notificateError()
        }
        else {
            saveSub(cell)
            
            if Reachability.isConnectedToNetwork() == true {
                println("Internet connection OK")
                var cloudManager = CloudKitManager.sharedInstance
                var manager = CoreDataManager.sharedInstance
                println(cell.subjectNameTF.text)
                cloudManager.insertSubject(cell.subjectNameTF.text)
                
                var alert = UIAlertView(title: "Disciplina Inserida!", message: "\(cell.subjectNameTF.text) foi inserida com sucesso!", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
                
                
            } else {
                println("Internet connection FAILED")
                var alert = UIAlertView(title: "Sem conexão de internet", message: "Verifique se sua conexão está ativa. Não Foi possível sincronizar com o servidor.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }

        }
        cell.subjectNameTF.text = ""
    }
    
    func notificateError(){
        let alertController = UIAlertController(title: "Não Permitido!", message: "Insira o nome de uma disciplina!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Voltar", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func saveSub(cell: SubjectCell){
        manager.insertSubject(cell.subjectNameTF.text)
        subjectNameArray = subjectsName().stringType
        tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().postNotificationName("teste", object: nil)
    }
    
    //#mark group methods
   
    func subjectsName() ->(stringType:[String], subjectsType:[Subjects]) {
        var subjectsName = [String]()
        subjectsArray = manager.selectSubjects() as! [Subjects]
        for newSubject in subjectsArray {
            subjectsName.append(newSubject.name)
        }
        return (subjectsName,subjectsArray)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
