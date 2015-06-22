//
//  Evaluation.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 20/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import UIKit

class Evaluation: NSObject {
     var type: String!
     var date: NSDate!
     var name: String!
     var subject: String!
    
    init(newType: String, newDate: NSDate,  newName: String, newSubject: String) {
        type = newType
        date = newDate
        name = newName
        subject = newSubject
    }
    
    override init() {
        
    }

}
