//
//  SubjectViewController.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 10/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class SubjectViewController: UITableViewController,UISearchBarDelegate{

    let manager = CoreDataManager.sharedInstance
    var subjectsArray:[Subjects]!
    var subjectNameArray:[String]!
    var isSearchActive:Bool = false
    var filteredSearch:[String] = []
    @IBOutlet weak var searchBar:UISearchBar!

    
    @IBOutlet weak var searchHeaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewWillAppear(animated: Bool) {
        subjectsArray = subjectsName().subjectsType
        subjectNameArray = subjectsName().stringType
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return manager.selectSubjects().count
        
    }
    
    //#pragma UISearchBarDelegate methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isSearchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        isSearchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarText = searchBar.text
        if (searchBarText?.isEmpty != nil) {
            isSearchActive = false
            tableView.reloadData()
        }
        else {
            isSearchActive = true
            filteredSearch.removeAll(keepCapacity: true)
            for index in 1 ... subjectNameArray.count {
                var currentString = filteredSearch[index]
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    filteredSearch.append(currentString)
                }
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {        
        
            let cell = tableView.dequeueReusableCellWithIdentifier("subjectCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = subjectNameArray[indexPath.row]

            return cell
    }
    
    

    
    
    //#mark group methods
    @IBAction func saveSubject(sender: AnyObject) {
       
    }
    
    func subjectsName() ->(stringType:[String], subjectsType:[Subjects]) {
        var subjectsName = [String]()
        subjectsArray = manager.selectSubjects() as! [Subjects]
        for newSubject in subjectsArray {
            subjectsName.append(newSubject.name)
        }
        return (subjectsName,subjectsArray)
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
