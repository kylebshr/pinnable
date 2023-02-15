//
//  UILayoutGuide+Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension UILayoutGuide: Pinnable {
    /// Equivalent to `bottomAnchor`.
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    /// Equivalent to `bottomAnchor`.
    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    public var superview: UIView? {
        owningView?.superview
    }
}
