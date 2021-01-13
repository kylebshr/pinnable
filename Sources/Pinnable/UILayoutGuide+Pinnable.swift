//
//  UILayoutGuide+Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension UILayoutGuide: Pinnable {
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }
}
