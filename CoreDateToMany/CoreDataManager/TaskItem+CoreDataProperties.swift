//
//  Employee+CoreDataProperties.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var note: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var id: Int64
    @NSManaged public var categories: Category?
    
    public var unwrappedName: String {
        name ?? "Unknown task"
    }
    public var timestampDate: Date {
        timestamp ?? Date.now
    }
    public var aNote: String {
        note ?? "No rating"
    }
    public var isCompleted: Bool {
        isComplete 
    }
    public var identifient: Int64 {
        id
    }

}

extension TaskItem : Identifiable {

}
