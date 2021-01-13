//
//  NSLayoutDimension+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

public extension NSLayoutDimension {
    @objc @discardableResult func pin(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(equalToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult func pin(
        greaterThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult func pin(
        lessThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult func pin(
        to anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(equalTo: anchor, multiplier: multiplier, constant: constant).prioritize(priority).setUp()
    }

    @objc @discardableResult func pin(
        greaterThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    @objc @discardableResult func pin(
        lessThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1, constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }
}
