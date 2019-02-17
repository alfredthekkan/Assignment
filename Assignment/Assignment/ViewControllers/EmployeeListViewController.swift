//
//  EmployeeListViewController.swift
//  Assignment
//
//  Created by Alfred Thekkan on 2/17/19.
//  Copyright © 2019 Alfred Thekkan. All rights reserved.
//

import UIKit

/*
 * class EmployeeListViewController will be used list the employees in the directory
 */
class EmployeeListViewController: UIViewController {
    
    /*
    The employees model array
    */
    var employees: [Employee] = []
    
    /*
    The tableview that lists the employees
    */
    lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableview, top: 0, left: 0, bottom: 0, right: 0)
        tableview.dataSource = self
        
        tableview.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()

    //MARK :- View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDirectoryUpdate(notification:)), name: Notification.Name.EmployeeDirectoryUpdated, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    /// This method upates the directory.
    ///
    ///
    /// Usage:
    ///
    ///    setup()
    ///
    /// - parameter @none
    /// - Returns: @none
    private func setup() {
        
        // updates the directory
        EmployeeDirectory.shared.update()
        
        // Add sort button to the navigation bar.
        let button = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sort))
        self.navigationItem.rightBarButtonItem = button
        
        // Add title and background color
        self.title = "Employee Directory"
        self.view.backgroundColor = .white
    }
    
    /// This method is invoked when the directory finishes updating. The ui update should be initiated from here
    ///
    ///
    /// - parameter @notification
    /// - Returns: @none
    @objc func receiveDirectoryUpdate(notification: Notification) {
        guard let directory = notification.object as? EmployeeDirectory else { return }
        self.employees = directory.employees
        print(#function)
        tableview.reloadData()
    }
    
    /// Sorts the employee list by name
    ///
    ///
    /// Usage:
    ///
    ///    sort()
    ///
    /// - parameter @none
    /// - Returns: @none
    @objc func sort() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.employees.sort { $0.name < $1.name }
            DispatchQueue.main.async { [weak self] in
                self?.tableview.reloadData()
            }
        }
    }
}

//MARK :- Table view data source
extension EmployeeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? EmployeeTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let employee = employees[indexPath.row]
        cell.setup(employee)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
}
