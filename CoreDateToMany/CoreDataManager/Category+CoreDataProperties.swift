//
//  Company+CoreDataProperties.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var tasks: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    public var IconName: String {
        icon ?? "star.fill"
    }
    
    public var tasksArray: [TaskItem] {
        let taskSet = tasks as? Set<TaskItem> ?? []
        
        return taskSet.sorted(by: { tasks, tasks in
            tasks.unwrappedName < tasks.unwrappedName
        })
    }

}

// MARK: Generated accessors for employees
extension Category {

    @objc(addTasksObject:)
    @NSManaged public func addToEmployees(_ value: TaskItem)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromEmployees(_ value: TaskItem)

    @objc(addTasks:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}

extension Category : Identifiable {

}
