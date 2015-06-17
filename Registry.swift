//
//  Registry.swift
//  Student Reminder
//
//  Created by Andre Lucas Ota on 17/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import Foundation
import CoreData

class Registry: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var grade: NSNumber
    @NSManaged var name: String
    @NSManaged var sent: NSNumber
    @NSManaged var type: String
    @NSManaged var subject: Subjects
}
