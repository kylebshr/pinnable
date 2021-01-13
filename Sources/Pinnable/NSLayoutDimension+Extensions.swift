//
//  NSLayoutDimension+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension NSLayoutDimension {
    @objc @discardableResult public func pin(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(equalToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult public func pin(
        greaterThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(greaterThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult public func pin(
        lessThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(lessThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult public func pin(
        to anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).prioritize(priority).setUp()
    }

    @objc @discardableResult public func pin(
        greaterThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult public func pin(
        lessThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1, constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }
}
