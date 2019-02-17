//
//  EmployeeDirectory.swift
//  Assignment
//
//  Created by Alfred Thekkan on 2/17/19.
//  Copyright © 2019 Alfred Thekkan. All rights reserved.
//

import Foundation

class EmployeeDirectory {
    
    /* Employees */
    public private(set) var employees: [Employee] = []
    
    /* Flag to check if list is updating */
    public private(set) var isUpdating: Bool = false
    
    /* Shared directory */
    static let shared = EmployeeDirectory()
    
    private init(){}
    
    /// Initiates update
    ///
    ///
    /// Usage:
    ///
    ///    update()
    ///
    /// - parameter @none
    /// - Returns: @none
    func update() {
        guard !isUpdating else { return }
        isUpdating.toggle()
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.doUpdateInBackground()
        }
    }
    
    /// Method to update the directory
    ///
    ///
    /// Usage:
    ///
    ///    doUpdateInBackground()
    ///
    /// - parameter @none
    /// - Returns: @none
    func doUpdateInBackground() {
        sleep(2)
        var employees: [Employee] = []
        let names = ["Anne", "Lucas", "Marc", "Zeus", "Hermes", "Bart", "Paul", "John", "Ringo", "Dave", "Taylor"]
        let surnames = ["Hawkins", "Simpson", "Lennon", "Grohl", "Hawkins", "Jacobs", "Holmes", "Mercury", "Matthews"]
        let count = names.count * surnames.count
        
        for _ in 0..<count {
            
            let name = names[Int(arc4random())%names.count]
            let surname = surnames[Int(arc4random())%surnames.count]
            let birthYear = 1997 - arc4random()%50
            
            let employee = Employee(name: "\(name) \(surname)", birthYear: UInt(birthYear))
            employees.append(employee)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.updateDidFinish(with: employees)
        }
    }
    
    /// Called when directory finished update.
    ///
    ///
    /// Usage:
    ///
    ///    updateDidFinish(with: employees)
    ///
    /// - parameter @results - The updated employee list
    /// - Returns: @none
    func updateDidFinish(with results: [Employee]) {
        self.employees = results
        isUpdating = false
        NotificationCenter.default.post(name: Notification.Name.EmployeeDirectoryUpdated, object: self)
    }
}

