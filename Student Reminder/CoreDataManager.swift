//
//  CoreDataManager.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 02/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    var error:NSError?
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //returns all the data from the designated entity and/or the related entity description
    func getEntity(entityName:String) -> (entity:[AnyObject], entityDescription: NSEntityDescription) {
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        
        return (objects!, entityDescription!)
        
    }
    
//    MARK: Evaluation
    //dependendo da pra colocar em outro metodo
    func selectEvaluations() -> [NSManagedObject]{
        var entity = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.entity = entity
        
        request.sortDescriptors = [sortDescriptor]
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        var arrayReturn: [NSManagedObject] = []
        
        if let results = objects{
            for result in results {
                let match = result as! NSManagedObject
                let nome:AnyObject = match.valueForKey("name")!
                var date: AnyObject = match.valueForKey("date")!
                
                arrayReturn.append(match)
            }
        }
        
        return arrayReturn
    }
    
    func insertEvaluations(evalName:String, evalType:String, evalDate: NSDate, evalSubject:Subjects) {
        
        let entity = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entity
        
        var newEvaluation = Evaluations(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        newEvaluation.name = evalName
        newEvaluation.type = evalType
        newEvaluation.date = evalDate
        newEvaluation.subject = evalSubject
        managedObjectContext?.save(&error)
    }
    
    func removeEvaluation(objectToRemove: NSManagedObject){
        managedObjectContext?.deleteObject(objectToRemove)
        managedObjectContext?.save(&error)
    }
    
    func updateEvaluation(name: String, type: String, date: NSDate, subject: Subjects, id: NSManagedObjectID) {
        
        let entity = managedObjectContext?.objectWithID(id)
        
        entity?.setValue(name, forKey: "name")
        entity?.setValue(type, forKey: "type")
        entity?.setValue(date, forKey: "date")
        entity?.setValue(subject, forKey: "subject")
        managedObjectContext?.save(&error)
    }
    
//    MARK: Registry
    func selectRegistrys() -> [NSManagedObject]{
        var entity = NSEntityDescription.entityForName("Registry", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.entity = entity
        
        request.sortDescriptors = [sortDescriptor]
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        var arrayReturn: [NSManagedObject] = []
        
        if let results = objects{
            for result in results {
                let match = result as! NSManagedObject
                let nome:AnyObject = match.valueForKey("name")!
                var date: AnyObject = match.valueForKey("date")!
                
                arrayReturn.append(match)
            }
        }
        
        return arrayReturn
    }
    
    func insertRegistry(regName:String, regType:String, regDate: NSDate, regSubject:Subjects) {
        
        let entity = NSEntityDescription.entityForName("Registry", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entity
        
        var newRegistry = Registry(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        newRegistry.name = regName
        newRegistry.type = regType
        newRegistry.date = regDate
        newRegistry.subject = regSubject
        newRegistry.grade = 0.0
        newRegistry.sent = false
        managedObjectContext?.save(&error)
    }
    
    func updateRegistry(name: String, sent: Bool, grade: Float, id: NSManagedObjectID) {
        
        let entity = managedObjectContext?.objectWithID(id)
        
        entity?.setValue(name, forKey: "name")
        entity?.setValue(grade, forKey: "grade")
        entity?.setValue(sent, forKey: "sent")
        managedObjectContext?.save(&error)
    }
    
//    MARK: Subjects
    
    //acho que podemos até usar em outra classe, e retornar algo nele
    func selectSubjects() -> [AnyObject] {
        var entity = NSEntityDescription.entityForName("Subjects", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        request.entity = entity
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        
//        if let results = objects
//        {
//            for result in results {
//                let match = result as! NSManagedObject
//                var name: AnyObject? = match.valueForKey("name")
//                println(name)
//            }
//        }
        
        return objects!
    }
    
    func selectSubject(subjectName: String)-> Subjects {
        var entity = NSEntityDescription.entityForName("Subjects", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        var predicate = NSPredicate(format: "name = %@",subjectName)
        request.predicate = predicate
        request.entity = entity
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        if let results = objects {
            for result in results  {
//                println(result.valueForKey("name"))
                if(result.valueForKey("name")as! String == subjectName) {
                    return result as! Subjects
                }
            }
        }
        //não sei como ajeitar isso exatamente
        return Subjects()
    }
    
    func insertSubject(subName:String) {
        var entity = NSEntityDescription.entityForName("Subjects", inManagedObjectContext: managedObjectContext!)
        
        var request = NSFetchRequest()
        request.entity = entity
        
        var newSubject: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Subjects", inManagedObjectContext: managedObjectContext!)
        
        newSubject.setValue(subName, forKey: "name")
        managedObjectContext?.save(&error)
    }
    
    func removeSubject(objectToRemove: NSManagedObject){
        managedObjectContext?.deleteObject(objectToRemove)
        managedObjectContext?.save(&error)
    }
    
//    MARK: Notification
    func insertNotification(addNotification:UILocalNotification) {
        var entity = NSEntityDescription.entityForName("Notification", inManagedObjectContext: managedObjectContext!)
        
        var request = NSFetchRequest()
        request.entity = entity
        
        var newNotification: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Notification", inManagedObjectContext: managedObjectContext!)
        
        newNotification.setValue(addNotification, forKey: "notification")
        managedObjectContext?.save(&error)
        
    }
    
    func selectNotification()->[AnyObject] {
        var entity = NSEntityDescription.entityForName("Notification", inManagedObjectContext: managedObjectContext!)
        
        var request = NSFetchRequest()
        request.entity = entity
        
        var fetchedObjects = managedObjectContext?.executeFetchRequest(request, error: &error)
        
        return fetchedObjects!
        
    }
    
//    MARK: Aux
    func selectEvaluationDates() -> [NSDate] {
        var entity = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.entity = entity
        
        request.sortDescriptors = [sortDescriptor]
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        var arrayReturn: [NSDate] = []
        
        if let results = objects{
            for result in results {
                let match = result as! NSManagedObject
                var date: AnyObject = match.valueForKey("date")!
                println(date)
                println("---XXXX----XXXX----XXXX----XXXX")
                
                arrayReturn.append(date as! NSDate)
            }
        }
        return arrayReturn

    }
    
    func debug(){
        let evals = self.selectEvaluations()
        let subjects  = self.selectSubjects() as! [Subjects]
        
        println("EVALUATIONS")
        
        for eval in evals{
            let newEval = eval as! Evaluations
            println(newEval.name)
            println(newEval.type)
            println(newEval.subject.name)
            
            let formatt = NSDateFormatter()
            formatt.dateStyle = NSDateFormatterStyle.ShortStyle
            formatt.timeStyle = NSDateFormatterStyle.ShortStyle
            println(formatt.stringFromDate(newEval.date))
            
            println("")
        }
        
        println("X-----X-----X-----X-----X")
        println("SUBJECTS")
        
        for sub in subjects{
            println(sub.name)
        }
        
    }

}

