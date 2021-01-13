//
//  UILayoutGuide+Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

extension UILayoutGuide: Pinnable {
    var firstBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    var lastBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }
}
