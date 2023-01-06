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
    @NSManaged public var employees: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    public var IconName: String {
        icon ?? "star.fill"
    }
    
    public var employeesArray: [Employee] {
        let employeeSet = employees as? Set<Employee> ?? []
        
        return employeeSet.sorted(by: { employees, employees in
            employees.unwrappedName < employees.unwrappedName
        })
    }

}

// MARK: Generated accessors for employees
extension Category {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}

extension Category : Identifiable {

}
