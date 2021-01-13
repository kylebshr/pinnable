//
//  Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

public protocol Pinnable: AnyObject {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension Pinnable {
    @discardableResult public func pinEdges(
        _ edges: UIRectEdge = .all,
        to object: Pinnable,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        let top = edges.contains(.top) ? topAnchor.pin(to: object.topAnchor, constant: insets.top) : nil
        let left = edges.contains(.left) ? leadingAnchor.pin(to: object.leadingAnchor, constant: insets.left) : nil
        let bottom = edges.contains(.bottom) ? bottomAnchor.pin(to: object.bottomAnchor, constant: -insets.bottom) : nil
        let right = edges.contains(.right) ? trailingAnchor.pin(to: object.trailingAnchor, constant: -insets.right) : nil

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()

        let constraints = [left, right, top, bottom].compactMap { $0 }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    @discardableResult public func pinCenter(
        to object: Pinnable,
        offset: UIOffset = .zero
    ) -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
        let centerX = centerXAnchor.pin(to: object.centerXAnchor, constant: offset.horizontal)
        let centerY = centerYAnchor.pin(to: object.centerYAnchor, constant: offset.vertical)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([centerX, centerY])

        return (x: centerX, y: centerY)
    }

    @discardableResult public func pinSize(
        to object: Pinnable
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.pin(to: object.heightAnchor)
        let width = widthAnchor.pin(to: object.widthAnchor)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    @discardableResult public func pinSize(
        to size: CGSize
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.pin(to: size.height)
        let width = widthAnchor.pin(to: size.width)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    @discardableResult public func pinSize(
        to constant: CGFloat
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        pinSize(to: CGSize(width: constant, height: constant))
    }

    internal func disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded() {
        if let self = self as? UIView {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
}
