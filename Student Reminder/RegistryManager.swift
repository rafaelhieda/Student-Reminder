//
//  RegistryManager.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 17/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreData

class RegistryManager: NSObject{
    static let sharedInstance = RegistryManager()
    let coreDataManager = CoreDataManager.sharedInstance
    let notificationManager = NotificationManager.sharedInstance
    
    func updateRegistry(){
        var evalArray = coreDataManager.selectEvaluations() as! [Evaluations]
//        var registryArray: [Evaluations] = []
        
        if (!evalArray.isEmpty){
            let nowDate = NSDate()
            var firstEval = evalArray.first
            var evalDate = firstEval?.date
            
            println(firstEval?.name)
            
            var pass = isGreaterThanDate(nowDate, lowerDate: evalDate!)
            println(pass)
            
            while (pass){
                self.addRegistry(firstEval!)
                coreDataManager.removeEvaluation(firstEval!)
                evalArray.removeAtIndex(0)
                
                if(evalArray.first != nil){
                    firstEval = evalArray.first
                    evalDate = firstEval?.date
                    pass = isGreaterThanDate(nowDate, lowerDate: evalDate!)
                }
                else{
                    pass = false
                }
            }
        }
    }
    
    func addRegistry(reg: Evaluations){
        let regName = reg.name
        let regDate = reg.date
        let regSubject = reg.subject
        let regType = reg.type
        
        coreDataManager.insertRegistry(regName, regType: regType, regDate: regDate, regSubject: regSubject)
    }
    
    func isGreaterThanDate(greatDate : NSDate, lowerDate: NSDate) -> Bool{
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if greatDate.compare(lowerDate) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
}
