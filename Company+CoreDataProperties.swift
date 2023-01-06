//
//  Company+CoreDataProperties.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
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
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}

extension Company : Identifiable {

}
