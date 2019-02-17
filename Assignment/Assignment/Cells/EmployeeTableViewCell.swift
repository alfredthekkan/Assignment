//
//  EmployeeTableViewCell.swift
//  Assignment
//
//  Created by Alfred Thekkan on 2/17/19.
//  Copyright © 2019 Alfred Thekkan. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    lazy var verticalStackView: UIStackView = {
        
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        horizontalStackView.addArrangedSubview(stackview)
        return stackview
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.distribution = .fill
        contentView.addSubview(stackview, top: 10, left: 10, bottom: 10, right: 10)
        return stackview
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        verticalStackView.addArrangedSubview(label)
        return label
    }()
    
    lazy var dobLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        verticalStackView.addArrangedSubview(label)
        return label
    }()
    
    lazy var salaryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        horizontalStackView.addArrangedSubview(label)
        return label
    }()
    
    func setup(_ employee: Employee) {
        
        nameLabel.text = employee.name
        dobLabel.text = "\(employee.age) years"
        salaryLabel.text = employee.formattedSalary
    }
}
