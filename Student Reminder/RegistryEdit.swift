//
//  RegistryEdit.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 17/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class RegistryEdit: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var grade: UITextField!
    @IBOutlet weak var status: UISegmentedControl!
    
    var registry: Registry!
    
    let coreDataManager = CoreDataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(registry.description)
        
        //status.selectedSegmentIndex deve ser igual ao status atual
        status.selectedSegmentIndex = 0
    }
    
    @IBAction func save(sender: AnyObject) {
        let newName = getNewName()
        let newGrade = getNewGrade()
        let newStatus = getNewStatus()
        
        coreDataManager.updateRegistry(newName, sent: newStatus, grade: newGrade, id: NSManagedObjectID())
    }
    
    func getNewName() -> String{
        if(name.text != "" && name.text != nil){
            return name.text
        }
        //Retornar nome antigo
        return ""
    }
    
    func getNewGrade() -> Float{
        if(grade.text != "" && grade.text != nil){
            let newGrade = (grade.text as NSString).floatValue
            
            if(newGrade > 0){
                return newGrade
            }
        }
        
        return 0.0
    }
    
    func getNewStatus() -> Bool{
        if (status.selectedSegmentIndex == 0){
            return false
        }
        else{
            return true
        }
    }
}
