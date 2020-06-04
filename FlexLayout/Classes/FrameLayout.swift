//
//  FrameLayout.swift
//  FlexLayout
//
//  Created by tbxark on 06/04/2020.
//  Copyright (c) 2020 tbxark. All rights reserved.
//


public struct FrameLayout {
    
    unowned let source: UIView
    init(_ view: UIView) {
        self.source = view
    }
    
    public func layout(_ block: (FrameLayout) -> Void) {
        block(self)
    }
    
    
    @discardableResult public func width(_ value: CGFloat) -> FrameLayout {
        source.frame.size.width = value
        return self
    }
    
    @discardableResult public func height(_ value: CGFloat) -> FrameLayout {
        source.frame.size.height = value
        return self
    }
    
    @discardableResult public func size(_ value: CGSize) -> FrameLayout {
        source.frame.size = value
        return self
    }
    
    
    @discardableResult public func minX(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.frame.origin.x = value - offset
        return self
    }
    
    @discardableResult public func minY(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.frame.origin.y = value - offset
        return self
    }
    
    @discardableResult public func min(_ value: CGPoint, offset: CGSize = .zero) -> FrameLayout {
        source.frame.origin.x = value.x - offset.width
        source.frame.origin.y = value.y - offset.height
        return self
    }
    
    @discardableResult public func midX(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.center.x = value - offset
        return self
    }
    
    @discardableResult public func midY(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.center.y = value - offset
        return self
    }
    
    @discardableResult public func mid(_ value: CGPoint, offset: CGSize = .zero) -> FrameLayout {
        source.center.x = value.x - offset.width
        source.center.y = value.y - offset.height
        return self
    }
    
    @discardableResult public func maxX(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.frame.origin.x = value - source.frame.width - offset
        return self
    }
    
    @discardableResult public func maxY(_ value: CGFloat, offset: CGFloat = 0) -> FrameLayout {
        source.frame.origin.y = value - source.frame.height - offset
        return self
    }
    
    @discardableResult public func max(_ value: CGPoint, offset: CGSize = .zero) -> FrameLayout {
        source.frame.origin.x = value.x - source.frame.width - offset.width
        source.frame.origin.y = value.y - source.frame.height - offset.height
        return self
    }
    
    
    @discardableResult public func horizontal(minX: CGFloat, maxX: CGFloat) -> FrameLayout {
        source.frame.origin.x = minX
        source.frame.size.width = maxX - minX
        return self
    }
    
    @discardableResult public func vertical(minY: CGFloat, maxY: CGFloat) -> FrameLayout {
        source.frame.origin.y = minY
        source.frame.size.height = maxY - minY
        return self
    }
}

extension UIView {
    public var fl: FrameLayout {
        return FrameLayout(self)
    }
}
