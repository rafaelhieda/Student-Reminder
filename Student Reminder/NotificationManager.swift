//
//  NotificationManager.swift
//  Student Reminder
//
//  Created by Rafael  Hieda on 15/06/15.
//  Copyright (c) 2015 Rafael Hieda. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NotificationManager: NSObject {
    static let sharedInstance = NotificationManager()
    var dateArray:[NSDate]!
    var manager = CoreDataManager.sharedInstance
    
    func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func filterNotifications() {
        var days:Int = 7
        var aux:Int = 0
        var dateNow = NSDate()
        var alertBody:String = ""
        
        var calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        aux = days
        let evalArray = manager.selectEvaluations() as! [Evaluations]
        if !evalArray.isEmpty {
            for index in 0 ... days {
            
                for evaluation in evalArray {
                    /*
                    talvez seja uma boa eu implementar uma classe de transição contendo date/nome/disciplina
                    criar um nsdictionary para guardar as tarefas de acordo com o dia
                    olhar no meu localNotificationTest a comparação de dias que faltam (Data cadastrada e data de hj, se forem <= 7 dias)
                    guardar dentro desse dictionary só as tarefas que estão prestes a serem disparadas.
                    lembrar que esse metodo tem que rodar no app delegate quando abrir o app e quando for fechado, caso haja modificacão e tal.
                    
                    */
                    
                    var evaluationName = evaluation.name as String
                    var date = evaluation.date as NSDate
                    var subject = evaluation.subject.name as String
                    
                    
                    println(evaluationName)
                    
                    let diffDate = (date.timeIntervalSinceDate(dateNow) / (60*60*24))
                    var roundedDiffDate = round(diffDate)
                    println(roundedDiffDate)
                    if roundedDiffDate == 0 {
                        alertBody = "\(evaluationName) de \(subject) está vencendo! Vence hoje!"
                    }
                    else if roundedDiffDate == 1 {
                        alertBody = "\(evaluationName) de \(subject) está vencendo! Faltam \(Int(roundedDiffDate)) dia"
                    }
                    else {
                        alertBody = "\(evaluationName) de \(subject) está vencendo! Faltam \(Int(roundedDiffDate)) dias"
                    }
                    
                    if roundedDiffDate >= 0 && roundedDiffDate <= 7 {
                        if roundedDiffDate <= Double(aux) {
                            var localNotification = UILocalNotification()
                            localNotification.alertTitle = "Tarefas a serem Entregues/Feitas:"
                            localNotification.alertBody = alertBody
                            localNotification.soundName = UILocalNotificationDefaultSoundName
                            localNotification.fireDate = dateNow.dateByAddingTimeInterval( (5 * NSTimeInterval(index)) )
                            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                        }
                        
                    }
                    
                }
                aux--
            }
        }
//        if !evalArray.isEmpty {
//            var localNotification = UILocalNotification()
//            localNotification.alertTitle = "Tarefas a serem Entregues/Feitas:"
//            localNotification.alertBody = alertBody
//            localNotification.fireDate = dateNow.dateByAddingTimeInterval(30)
//            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//            
//        }
        
    }
    
}