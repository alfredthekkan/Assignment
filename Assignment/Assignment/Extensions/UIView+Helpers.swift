//
//  UIView+Helpers.swift
//  Assignment
//
//  Created by Alfred Thekkan on 2/17/19.
//  Copyright © 2019 Alfred Thekkan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Adds the subview to the view with constraints.
    ///
    ///
    /// Usage:
    ///
    ///    addSubview(subview, top: 0, left: 0, bottom: 0, right: 0)
    ///
    /// - parameter @view - the subview to be added
    /// - parameter @top - the spacing from top
    /// - parameter @left - the spacing from left
    /// - parameter @bottom - the spacing from bottom
    /// - parameter @right - the spacing from right
    /// - Returns: @none
    public func addSubview(_ view: UIView, top: CGFloat?, left: CGFloat?, bottom: CGFloat?, right: CGFloat?) {
        self.addSubview(view)
        if let top = top {
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
        }
        if let left = left {
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: left).isActive = true
        }
        if let bottom = bottom {
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom * -1).isActive = true
        }
        if let right = right {
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: right * -1).isActive = true
        }
    }
}
