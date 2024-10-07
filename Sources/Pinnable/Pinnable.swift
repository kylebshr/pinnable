//
//  Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

/// A shared interface for the pinnable properties of `UIView` and `UILayoutGuide`.
@MainActor public protocol Pinnable: AnyObject {
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

    var superview: UIView? { get }
}

extension Pinnable {
    /// Constrain the edges of the receiver to the corresponding edges of the provided view or layout guide.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// - Parameters:
    ///   - edges: The edges to constrain. The `left` and `right` edge will constrain the `leading` and `trailing` anchors, respectively. Defaults to `.all`.
    ///   - object: The object to constrain the receiver to.
    ///   - insets: Optional insets to apply to the constraints. The top, left, bottom, and right constants will be applied to the top, leading, bottom, and trailing edges, respectively. Defaults to `.zero`.
    /// - Returns: A named tuple of the created constraints. The properties are optional, as edges not specified will not have constraints.
    @discardableResult public func pinEdges(
        _ edges: UIRectEdge = .all,
        to object: Pinnable,
        insets: UIEdgeInsets = .zero
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        let top = edges.contains(.top) ? topAnchor.pin(to: object.topAnchor, constant: insets.top) : nil
        let leading = edges.contains(.left) ? leadingAnchor.pin(to: object.leadingAnchor, constant: insets.left) : nil
        let bottom = edges.contains(.bottom) ? bottomAnchor.pin(to: object.bottomAnchor, constant: -insets.bottom) : nil
        let trailing = edges.contains(.right) ? trailingAnchor.pin(to: object.trailingAnchor, constant: -insets.right) : nil

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([top, leading, bottom, trailing].compactMap { $0 })

        return (top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    /// Constrain the edges of the receiver to the corresponding edges of its superview. It is a programmer error to call this method on an object that does not have a superview.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// - Parameters:
    ///   - edges: The edges to constrain. The `left` and `right` edge will constrain the `leading` and `trailing` anchors, respectively. Defaults to `.all`.
    ///   - insets: Optional insets to apply to the constraints. The top, left, bottom, and right constants will be applied to the top, leading, bottom, and trailing edges, respectively. Defaults to `.zero`.
    /// - Returns: A named tuple of the created constraints. The properties are optional, as edges not specified will not have constraints.
    @discardableResult public func pinEdgesToSuperview(
        _ edges: UIRectEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        guard let superview else {
            fatalError("Receiver must have a superview to use this method.")
        }

        return pinEdges(edges, to: superview, insets: insets)
    }

    /// Constrain the edges of the receiver to the corresponding edges of its superview’s layout margins. It is a programmer error to call this method on an object that does not have a superview.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// - Parameters:
    ///   - edges: The edges to constrain. The `left` and `right` edge will constrain the `leading` and `trailing` anchors, respectively. Defaults to `.all`.
    ///   - insets: Optional insets to apply to the constraints. The top, left, bottom, and right constants will be applied to the top, leading, bottom, and trailing edges, respectively. Defaults to `.zero`.
    /// - Returns: A named tuple of the created constraints. The properties are optional, as edges not specified will not have constraints.
    @discardableResult public func pinEdgesToSuperviewMargins(
        _ edges: UIRectEdge = .all,
        insets: UIEdgeInsets = .zero
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        guard let superview else {
            fatalError("Receiver must have a superview to use this method.")
        }

        return pinEdges(edges, to: superview.layoutMarginsGuide, insets: insets)
    }

    /// Constrain the center of the receiver to the center of the provided view or layout guide.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// - Parameters:
    ///   - object: The object to constrain the receiver to.
    ///   - offset: An optional offset for the constraints. The horizontal offset will be applied to the center X anchor, and the vertical offset will be applied to the center Y anchor. Defaults to `.zero`.
    /// - Returns: A named tuple of the created constraints.
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

    /// Constrain the size of the receiver to the size of the provided view or layout guide.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// To constrain a view or layout guide in a single dimension, pin the desired layout anchors directly instead, e.g.:
    ///
    ///     a.widthAnchor.pin(to: b.widthAnchor)
    ///
    /// - Parameters:
    ///   - object: The object to constrain the receiver to.
    /// - Returns: A named tuple of the created constraints.
    @discardableResult public func pinSize(
        to object: Pinnable
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.pin(to: object.heightAnchor)
        let width = widthAnchor.pin(to: object.widthAnchor)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    /// Constrain the size of the receiver to the provided constant size.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// To constrain a view or layout guide in a single dimension, pin the desired layout anchor directly instead, e.g.:
    ///
    ///     a.widthAnchor.pin(to: 100)
    ///
    /// - Parameters:
    ///   - object: The size to constrain the receiver to.
    /// - Returns: A named tuple of the created constraints.
    @discardableResult public func pinSize(
        to size: CGSize
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.pin(to: size.height)
        let width = widthAnchor.pin(to: size.width)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    /// Constrain the width and height of the receiver to the provided constant.
    ///
    /// If the receiver is a `UIView`, this method disables `translatesAutoresizingMaskIntoConstraints`.
    ///
    /// To constrain a view or layout guide in a single dimension, pin the desired layout anchor directly instead, e.g.:
    ///
    ///     a.widthAnchor.pin(to: 100)
    ///
    /// - Parameters:
    ///   - object: The size to constrain the receiver's width and height to.
    /// - Returns: A named tuple of the created constraints.
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
