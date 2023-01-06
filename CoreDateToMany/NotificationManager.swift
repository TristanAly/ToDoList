//
//  NotificationManager.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 06/01/2023.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager() // singleton
    
    func requestAuthorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (success, error) in
            if let error = error {
                print("Error \(error)")
            } else {
                print("success")
            }
        }
    }
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String)   {
        
        var trigger: UNNotificationTrigger?
        
        
        if type == "date"{
            let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            
           trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            content.badge = 1
            
        let request = UNNotificationRequest(identifier: "alertNotificationUnique", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
}

