//
//  NSLayoutAnchor+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension NSLayoutAnchor {
    /// Create an equal-to constraint between the receiver and the provided layout anchor.  The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        to anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Create a greater-than-or-equal-to constraint between the receiver and the provided layout anchor.  The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        greaterThan anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant)
            .prioritize(priority)
            .setUp()
    }

    /// Create a less-than-or-equal-to constraint between the receiver and the provided layout anchor.  The constraint is automatically activated.
    ///
    /// If the receiver is an anchor on a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints` on that view.
    ///
    /// - Parameters:
    ///   - anchor: The anchor to constrain the receiver to.
    ///   - constant: An optional constant for the constraint. Defaults to 0.
    ///   - priority: An optional priority for the constraint. Defaults to `.required`.
    /// - Returns: The constraint that was created.
    @objc @discardableResult public func pin(
        lessThan anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant)
            .prioritize(priority)
            .setUp()
    }
}
