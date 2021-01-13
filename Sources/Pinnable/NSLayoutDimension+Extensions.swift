//
//  NSLayoutDimension+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension NSLayoutDimension {
    /// Constrain the receiver to a constant size.  The constraint is automatically activated.
    /// - Parameters:
    ///   - constant: The size to constrain the receiver to.
    ///   - priority: The priority of the constraint.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(equalToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Constrain the receiver greater-than-or-equal to a constant size.  The constraint is automatically activated.
    /// - Parameters:
    ///   - constant: The size to constrain the receiver to.
    ///   - priority: The priority of the constraint.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        greaterThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Constrain the receiver less-than-or-equal to a constant size.  The constraint is automatically activated.
    /// - Parameters:
    ///   - constant: The size to constrain the receiver to.
    ///   - priority: The priority of the constraint.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        lessThan constant: CGFloat,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Create an equal-to constraint between the receiver and the provided layout anchor. The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - multiplier: An optional multiplier for the constraint. Defaults to 1.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        to anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Create a greater-than-or-equal-to constraint between the receiver and the provided layout anchor. The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - multiplier: An optional multiplier for the constraint. Defaults to 1.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        greaterThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Create a less-than-or-equal-to constraint between the receiver and the provided layout anchor. The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - multiplier: An optional multiplier for the constraint. Defaults to 1.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        lessThan anchor: NSLayoutDimension,
        multiplier: CGFloat = 1, constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            .prioritize(priority)
            .setUp()
    }
}
