//
//  Pinnable.swift
//
//
//  Created by Kyle Bashour on 1/12/21.
//

import UIKit

/// A shared interface for the pinnable properties of `UIView` and `UILayoutGuide`.
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
    /// Constrain the edges of the receiver to the corresponding edges of the provided view or layout guide.
    ///
    /// - Parameters:
    ///   - edges: The edges to constrain. Defaults to `.all`.
    ///   - object: The object to constrain the receiver to.
    ///   - insets: Optional insets to apply to the constraints. Defaults to `.zero`.
    ///   - priority: An optional priority for the constraints. Defaults to `.required`.
    /// - Returns: A named tuple of the created constraints. The properties are optional, as edges not specified will not have constraints.
    @available(iOS 13.0, *)
    @discardableResult public func pinEdges<P: Pinnable>(
        _ edges: NSDirectionalRectEdge = .all,
        to object: P,
        insets: NSDirectionalEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        let top = edges.contains(.top) ? topAnchor.constraint(equalTo: object.topAnchor, constant: insets.top) : nil
        let leading = edges.contains(.leading) ? leadingAnchor.constraint(equalTo: object.leadingAnchor, constant: insets.leading) : nil
        let bottom = edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: object.bottomAnchor, constant: -insets.bottom) : nil
        let trailing = edges.contains(.trailing) ? trailingAnchor.constraint(equalTo: object.trailingAnchor, constant: -insets.trailing) : nil

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([top, leading, bottom, trailing].compactMap { $0?.prioritize(priority) })

        return (top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    /// Constrain the edges of the receiver to the corresponding edges of the provided view or layout guide.
    ///
    /// - Parameters:
    ///   - edges: The edges to constrain. The `left` and `right` edge will constrain the `leading` and `trailing` anchors, respectively. Defaults to `.all`.
    ///   - object: The object to constrain the receiver to.
    ///   - insets: Optional insets to apply to the constraints. The top, left, bottom, and right constants will be applied to the top, leading, bottom, and trailing edges, respectively. Defaults to `.zero`.
    ///   - priority: An optional priority for the constraints. Defaults to `.required`.
    /// - Returns: A named tuple of the created constraints. The properties are optional, as edges not specified will not have constraints.

    @available(iOS, deprecated: 13.0, message: "Use leading and trailing instead of left and right, respectively.")
    @_disfavoredOverload @discardableResult public func pinEdges<P: Pinnable>(
        _ edges: UIRectEdge = .all,
        to object: P,
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority = .required
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        let top = edges.contains(.top) ? topAnchor.constraint(equalTo: object.topAnchor, constant: insets.top) : nil
        let leading = edges.contains(.left) ? leadingAnchor.constraint(equalTo: object.leadingAnchor, constant: insets.left) : nil
        let bottom = edges.contains(.bottom) ? bottomAnchor.constraint(equalTo: object.bottomAnchor, constant: -insets.bottom) : nil
        let trailing = edges.contains(.right) ? trailingAnchor.constraint(equalTo: object.trailingAnchor, constant: -insets.right) : nil

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([top, leading, bottom, trailing].compactMap { $0?.prioritize(priority) })

        return (top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    /// Constrain the center of the receiver to the center of the provided view or layout guide.
    ///
    /// - Parameters:
    ///   - object: The object to constrain the receiver to.
    ///   - offset: An optional offset for the constraints. The horizontal offset will be applied to the center X anchor, and the vertical offset will be applied to the center Y anchor. Defaults to `.zero`.
    /// - Returns: A named tuple of the created constraints.
    @discardableResult public func pinCenter<P: Pinnable>(
        to object: P,
        offset: UIOffset = .zero
    ) -> (x: NSLayoutConstraint, y: NSLayoutConstraint) {
        let centerX = centerXAnchor.constraint(equalTo: object.centerXAnchor, constant: offset.horizontal)
        let centerY = centerYAnchor.constraint(equalTo: object.centerYAnchor, constant: offset.vertical)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([centerX, centerY])

        return (x: centerX, y: centerY)
    }

    /// Constrain the size of the receiver to the size of the provided view or layout guide.
    ///
    /// Note: to constrain a view or layout guide in a single dimension, pin the desired layout anchors directly, e.g.:
    ///
    ///     a.widthAnchor.pin(to: b.widthAnchor)
    ///
    /// - Parameters:
    ///   - object: The object to constrain the receiver to.
    /// - Returns: A named tuple of the created constraints.
    @discardableResult public func pinSize<P: Pinnable>(
        to object: P
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.constraint(equalTo: object.heightAnchor)
        let width = widthAnchor.constraint(equalTo: object.widthAnchor)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    /// Constrain the size of the receiver to the provided constant size.
    ///
    /// Note: to constrain a view or layout guide in a single dimension, pin the desired layout anchor directly, e.g.:
    ///
    ///     a.widthAnchor.pin(to: 100)
    ///
    /// - Parameters:
    ///   - object: The size to constrain the receiver to.
    /// - Returns: A named tuple of the created constraints.
    @discardableResult public func pinSize(
        to size: CGSize
    ) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let height = heightAnchor.constraint(equalToConstant: size.height)
        let width = widthAnchor.constraint(equalToConstant: size.width)

        disableTranslatesAutoresizingMaskIntoConstraintsIfNeeded()
        NSLayoutConstraint.activate([height, width])

        return (width: width, height: height)
    }

    /// Constrain the width and height of the receiver to the provided constant.
    ///
    /// Note: to constrain a view or layout guide in a single dimension, pin the desired layout anchor directly, e.g.:
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
