//
//  ConstraintLayout.swift
//  FlexLayout
//
//  Created by tbxark on 01/22/2021.
//  Copyright (c) 2021 tbxark. All rights reserved.
//



infix operator |== : ComparisonPrecedence
infix operator |>= : ComparisonPrecedence
infix operator |<= : ComparisonPrecedence

public typealias CL = ConstraintLayout

@_functionBuilder
public struct ConstraintLayout {
    public static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return components
    }
    
    public static func layout(_ view: UIView, @ConstraintLayout _ builder: () -> [NSLayoutConstraint]) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(builder())
    }
    public static func layout(@ConstraintLayout _ builder: () -> [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(builder())
    }
}


// MARK: - NSLayoutDimension
public func |== (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalToConstant: rhs)
}

public func |>= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint  {
    return lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

public func |<= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualToConstant: rhs)
}

// MARK: - NSLayoutAnchor
public func |== <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchor<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(equalTo: rhs)
}

public func |>= <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchor<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

public func |<= <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchor<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

// MARK: - NSLayoutAnchorWithConst
public typealias NSLayoutAnchorWithConst<Anchor: AnyObject> = (anchor: NSLayoutAnchor<Anchor>, constant: CGFloat)

public func + <Anchor>(lhs: NSLayoutAnchor<Anchor>, constant: CGFloat) -> NSLayoutAnchorWithConst<Anchor> where Anchor: AnyObject  {
    return (anchor: lhs, constant: constant)
}

public func - <Anchor>(lhs: NSLayoutAnchor<Anchor>, constant: CGFloat) -> NSLayoutAnchorWithConst<Anchor> where Anchor: AnyObject  {
    return (anchor: lhs, constant: -constant)
}

public func |== <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchorWithConst<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
}

public func |>= <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchorWithConst<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
}

public func |<= <Anchor>(lhs: NSLayoutAnchor<Anchor>, rhs: NSLayoutAnchorWithConst<Anchor>) -> NSLayoutConstraint where Anchor: AnyObject {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
}


// MARK: - NSLayoutAnchorWithMultiplier
public typealias NSLayoutAnchorWithMultiplier = (anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)

public func * (lhs: NSLayoutDimension, multiplier: CGFloat) -> NSLayoutAnchorWithMultiplier {
    return (anchor: lhs, multiplier: multiplier, constant: 0)
}

public func + (lhs: NSLayoutAnchorWithMultiplier, value: CGFloat) -> NSLayoutAnchorWithMultiplier {
    return (anchor: lhs.anchor, multiplier: lhs.multiplier, constant: lhs.constant + value)
}

public func |== (lhs: NSLayoutDimension, rhs: NSLayoutAnchorWithMultiplier) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

public func |>= (lhs: NSLayoutDimension, rhs: NSLayoutAnchorWithMultiplier) -> NSLayoutConstraint  {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

public func |<= (lhs: NSLayoutDimension, rhs: NSLayoutAnchorWithMultiplier) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}


