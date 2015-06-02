//
//  SentEvaluations.swift
//  
//
//  Created by Rafael  Hieda on 02/06/15.
//
//

import Foundation
import CoreData

class SentEvaluations: NSManagedObject {

    @NSManaged var sentCode: NSNumber
    @NSManaged var evaluationCode: Evaluations

}
