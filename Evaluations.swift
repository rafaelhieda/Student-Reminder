//
//  Evaluations.swift
//  
//
//  Created by Rafael  Hieda on 03/06/15.
//
//

import Foundation
import CoreData

class Evaluations: NSManagedObject {

    @NSManaged var type: String
    @NSManaged var grade: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var subject: Subjects

}
