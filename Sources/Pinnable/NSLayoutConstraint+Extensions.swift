//
//  NSLayoutConstraint+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

public extension NSLayoutConstraint {
    @discardableResult func activate() -> Self {
        isActive = true
        return self
    }

    @discardableResult func deactivate() -> Self {
        isActive = false
        return self
    }

    @discardableResult func prioritize(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    internal func setUp() -> NSLayoutConstraint {
        (firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        activate()
        return self
    }
}
