//
//  NSLayoutConstraint+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension NSLayoutConstraint {
    @discardableResult public func activate() -> Self {
        isActive = true
        return self
    }

    @discardableResult public func deactivate() -> Self {
        isActive = false
        return self
    }

    @discardableResult public func prioritize(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    internal func setUp() -> NSLayoutConstraint {
        (firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        activate()
        return self
    }
}
