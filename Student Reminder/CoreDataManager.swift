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
                println(nome)
                println(date)
                println("---XXXX----XXXX----XXXX----XXXX")
                
                arrayReturn.append(match)
            }
        }
        
        return arrayReturn
        
//        var results = self.getEntity("Evaluations").entity
//        for result in results {
//            let match = result as! NSManagedObject
//            var name: AnyObject? = match.valueForKey("Name")
//            var type: AnyObject? = match.valueForKey("type")
//            var grade: AnyObject? = match.valueForKey("grade")
//            var subject: AnyObject? = match.valueForKey("subject")
//            var date: AnyObject? = match.valueForKey("date")
//            println("--------------")
//            println(name)
//            println(type)
//            println(grade)
//            println(subject?.name)
//            println(date)
//            
//        }
    }
    
    func insertEvaluations(evalName:String, evalType:String, evalGrade:Float, evalDate: NSDate, evalSubject:Subjects) {
        
        let entity = NSEntityDescription.entityForName("Evaluations", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entity
        
        var newEvaluation = Evaluations(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        newEvaluation.name = evalName
        newEvaluation.type = evalType
        newEvaluation.grade = evalGrade
        newEvaluation.date = evalDate
        newEvaluation.subject = evalSubject
        managedObjectContext?.save(&error)
    }
    
    func removeEvaluation(objectToRemove: NSManagedObject){
        managedObjectContext?.deleteObject(objectToRemove)
    }
    
    //acho que podemos até usar em outra classe, e retornar algo nele
    func selectSubjects() -> [AnyObject] {
        var entity = NSEntityDescription.entityForName("Subjects", inManagedObjectContext: managedObjectContext!)
        var request = NSFetchRequest()
        request.entity = entity
        
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        
        if let results = objects
        {
            for result in results {
                let match = result as! NSManagedObject
                var name: AnyObject? = match.valueForKey("name")
                println(name)
                
            }
        }
        
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
                println(result.valueForKey("name"))
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
    
}

