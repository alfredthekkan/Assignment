//
//  Employee.swift
//  Assignment
//
//  Created by Alfred Thekkan on 2/17/19.
//  Copyright © 2019 Alfred Thekkan. All rights reserved.
//

import Foundation

class Employee {
    
    static let kStartingSalary: Double = 10000
    let salaryCurrency = "EUR"
    
    /* nName */
    var name: String
    
    /* Birth year */
    var birthYear: UInt
    
    /* Salary */
    private var salary: Double
    
    /* age */
    var age: UInt {
        let currentYear = Calendar.current.component(.year, from: Date())
        return UInt(currentYear) - birthYear
    }
    
    /* Formatted salary with currency symbol */
    var formattedSalary: String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = getSymbol(forCurrencyCode: salaryCurrency)
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: salary))
    }
    
    /// Initializer
    ///
    ///
    /// Usage:
    ///
    ///    Employee(name: "Alfred", birthYear: 1989)
    ///
    /// - parameter @name - Employee name
    /// - parameter @birthYear - birth year
    
    /// - Returns: Employee
    init(name: String, birthYear: UInt) {
        self.name = name
        self.birthYear = birthYear
        self.salary = Employee.kStartingSalary
    }
    
    /// Get symbol from currency code.
    ///
    ///
    /// Usage:
    ///
    ///    getSymbol(forCurrencyCode: salaryCurrency)
    ///
    /// - parameter @code - currency code
    /// - Returns: @String - currency symbol
    private func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}
