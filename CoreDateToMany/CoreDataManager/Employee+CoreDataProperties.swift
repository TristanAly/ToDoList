//
//  Employee+CoreDataProperties.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var note: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var id: Int64
    @NSManaged public var company: Company?
    
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

extension Employee : Identifiable {

}
