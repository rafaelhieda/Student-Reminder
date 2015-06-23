//
//  CloudKitManager.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 20/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitManager {
    static let sharedInstance = CloudKitManager()
    var container: CKContainer
    var publicData: CKDatabase
    var fetchedObjects: [Evaluation]
    
    init() {
        container = CKContainer.defaultContainer()
        publicData = container.publicCloudDatabase
        fetchedObjects = [Evaluation]()
    }
    
    func fetchEvaluations() {
        let query = CKQuery(recordType: "Evaluations", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        self.publicData.performQuery(query, inZoneWithID: nil) { results, error in
            if error == nil {
                if let records = results as? [CKRecord] {
                    for eachEval in results {
                        let newEvaluation = Evaluation()
                        newEvaluation.type = eachEval["type"] as! String
                        newEvaluation.name = eachEval["name"] as! String
                        newEvaluation.date = eachEval["date"] as! NSDate
                        newEvaluation.subject = eachEval["subject"] as! String
                        
                        self.fetchedObjects.append(newEvaluation)
                    }
                }
            }
            else {
                println(error)
            }
        }
    }
    
    func insertEvaluation(newEvaluation: Evaluation) {
        let query = CKQuery(recordType: "Evaluations", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        let record = CKRecord(recordType: "Evaluations")
        record.setValue(newEvaluation.name, forKey: "name")
        record.setValue(newEvaluation.date, forKey: "date")
        record.setValue(newEvaluation.subject,  forKey: "subject")
        record.setValue(newEvaluation.type, forKey: "type")
        publicData.saveRecord(record, completionHandler: { record, error in
            if error != nil {
                println(error)
            }
        })
    }
    
    func deleteEvaluation(oldEvaluation: Evaluation) {
        let query = CKQuery(recordType: "Evaluations", predicate: NSPredicate(format: "(name == %@) AND (date == %@) AND (subject == %@) and (type == %@)", argumentArray: [oldEvaluation.name, oldEvaluation.date, oldEvaluation.subject, oldEvaluation.type]))
        publicData.performQuery(query, inZoneWithID: nil, completionHandler: { results, error in
            if error == nil {
                if results.count > 0 {
                    let record:CKRecord! = results[0] as! CKRecord
                    println(record)
                    
                    self.publicData.deleteRecordWithID(record.recordID, completionHandler: { record, error  in
                        if error != nil {
                            println(error)
                        }
                    })
                }
            }
        })
    }
    
    func fetchSubjects() {
        var subjectsArray = [String]()
        let query = CKQuery(recordType: "Subjects", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        self.publicData.performQuery(query, inZoneWithID: nil, completionHandler: { results, error in
            if error == nil {
                if let records = results as? [CKRecord] {
                    for eachSubject in results {
                        subjectsArray.append(eachSubject["name"] as! String)
                    }
                }
            }
            else {
                println(error)
            }
            })
        
        
    }
}

//
