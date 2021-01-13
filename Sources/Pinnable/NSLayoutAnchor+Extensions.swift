//
//  NSLayoutAnchor+Extensions.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension NSLayoutAnchor {
    @objc @discardableResult public func pin(
        to anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(equalTo: anchor, constant: constant).prioritize(priority).setUp()
    }

    @objc @discardableResult public func pin(
        greaterThan anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(greaterThanOrEqualTo: anchor, constant: constant).prioritize(priority).setUp()
    }

    @objc @discardableResult public func pin(
        lessThan anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        self.constraint(lessThanOrEqualTo: anchor, constant: constant).prioritize(priority).setUp()
    }
}
