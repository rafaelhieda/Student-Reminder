//
//  RegistryEdit.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 17/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class RegistryEdit: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var grade: UITextField!
    @IBOutlet weak var status: UISegmentedControl!
    
    var oldName = ""
    var oldGrade = ""
    var oldStatus = 0
    
    var registry: Registry!
    
    let coreDataManager = CoreDataManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(registry.description)
        
        name.delegate = self
        grade.delegate = self
        
        self.setOldValues()
        
        //status.selectedSegmentIndex deve ser igual ao status atual
        status.selectedSegmentIndex = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    func setOldValues(){
        self.name.text = self.oldName
        self.grade.text = self.oldGrade
        self.status.selectedSegmentIndex = self.oldStatus
    }
    
    @IBAction func save(sender: AnyObject) {
        let newName = getNewName()
        let newGrade = getNewGrade()
        let newStatus = getNewStatus()
        
        coreDataManager.updateRegistry(newName, sent: newStatus, grade: newGrade, id: registry.objectID)
        
        self.viewWillDisappear(false)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
