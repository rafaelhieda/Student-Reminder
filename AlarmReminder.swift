//
//  AlarmReminder.swift
//  
//
//  Created by Rafael  Hieda on 02/06/15.
//
//

import Foundation
import CoreData

class AlarmReminder: NSManagedObject {

    @NSManaged var alarmCode: NSNumber
    @NSManaged var dateAlarm: NSDate

}
