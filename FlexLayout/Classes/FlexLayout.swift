//
//  FlexLayout.swift
//  FlexLayout
//
//  Created by tbxark on 06/04/2020.
//  Copyright (c) 2020 tbxark. All rights reserved.
//

import UIKit

public protocol FlexLayoutViewType: class {
    var frame: CGRect { get set }
}

extension UIView: FlexLayoutViewType {}

extension FlexLayoutViewType {
    public func stack(main: FlexLayout.Size, cross: FlexLayout.Cross = .grow) -> FlexLayout {
        return FlexLayout(view: self, main: main, cross: cross)
    }
}

public typealias FL = FlexLayout

@_functionBuilder
public struct FlexLayout {
    
   
   
    public var view: FlexLayoutViewType
    public var main: Size
    public var cross: Cross
    
    public static func buildBlock(_ components: FlexLayout...) -> [FlexLayout] {
        return components
    }
}

extension FlexLayout {
    public typealias Insets = (start: CGFloat, end: CGFloat)

    public enum Size {
        public static let grow = Size.stretch(1)
        case fixed(CGFloat)
        case stretch(CGFloat)
    }
    
    public enum Align {
        case start
        case center
        case end
    }
    
    public enum Direction {
        case vertical
        case horizontal
    }
    
    public enum Cross {
        public static let grow = Cross.stretch(margin: (start: 0, end: 0))
        public static func start(_ value: CGFloat) -> Cross {
            return .fixed(value, offset: 0, align: .start)
        }
        public static func center(_ value: CGFloat) -> Cross {
            return .fixed(value, offset: 0, align: .center)
        }
        public static func end(_ value: CGFloat) -> Cross {
            return .fixed(value, offset: 0, align: .end)
        }
        
        case fixed(CGFloat, offset: CGFloat, align: Align)
        case stretch(margin: (start: CGFloat, end: CGFloat))
    }
    
}

extension FlexLayout {
    public class Space: FlexLayoutViewType {
        public var frame: CGRect = .zero
        public init() {
        }
        
        public static func fixed(_ value: CGFloat) -> FlexLayout {
            return Space().stack(main: .fixed(value))
        }
        
        public static func grow() -> FlexLayout {
            return Space().stack(main: .grow)
        }
        
        public static func stretch(_ value: CGFloat) -> FlexLayout {
            return Space().stack(main: .stretch(value))
        }
    }
    
    public class Virtual: FlexLayoutViewType {
        public var frame: CGRect = .zero
        public var builder: (CGRect) -> Void
        
        public init(_ frame: CGRect = .zero, _ builder: @escaping (CGRect) -> Void) {
            self.frame = frame
            self.builder = builder
        }
    }
    
    public class Bind: FlexLayoutViewType {
        public var view: FlexLayoutViewType
        public var builder: (CGRect) -> Void
        
        public var frame: CGRect {
            get {
                return view.frame
            }
            set {
                view.frame = newValue
            }
        }
        
        
        public init(_ view: FlexLayoutViewType, _ builder: @escaping (CGRect) -> Void) {
            self.view = view
            self.builder = builder
        }
    }
    
}

extension FlexLayout {
    private static func layoutMainAxis(layouts: [FlexLayout], direction: FlexLayout.Direction, align: FlexLayout.Align, start: CGFloat, end: CGFloat) {
        
        var totalSize = CGFloat.zero
        var totalGrow = CGFloat.zero
        
        for l in layouts {
            switch l.main {
            case .fixed(let value):
                totalSize += value
            case .stretch(let scale):
                totalGrow += scale
            }
        }
        let growValue = (end - start - totalSize) / totalGrow
        var startPosition = start
        
        if totalGrow.isZero {
            switch align {
            case .start:
                startPosition = start
            case .center:
                startPosition = start + (end - start - totalSize) / 2
            case .end:
                startPosition = (end - totalSize)
            }
        }
        
        switch direction {
        case .horizontal:
            for l in layouts {
                switch l.main {
                case .stretch(let scale):
                    l.view.frame.origin.x = startPosition
                    l.view.frame.size.width = scale * growValue
                    startPosition = l.view.frame.maxX
                case .fixed(let value):
                    l.view.frame.origin.x = startPosition
                    l.view.frame.size.width = value
                    startPosition = l.view.frame.maxX
                }
            }
        case .vertical:
            for l in layouts {
                switch l.main {
                case .stretch(let scale):
                    l.view.frame.origin.y = startPosition
                    l.view.frame.size.height = scale * growValue
                    startPosition = l.view.frame.maxY
                case .fixed(let value):
                    l.view.frame.origin.y = startPosition
                    l.view.frame.size.height = value
                    startPosition = l.view.frame.maxY
                }
            }
            
        }
    }
    
    private static func layoutCorssAxis(layouts: [FlexLayout], direction: FlexLayout.Direction,  start: CGFloat, end: CGFloat) {
        switch direction {
        case .horizontal:
            for l in layouts {
                switch l.cross {
                case .fixed(let value, let offset, let align):
                    l.view.frame.size.height = value
                    switch align {
                    case .start:
                        l.view.frame.origin.y = start + offset
                    case .center:
                        l.view.frame.origin.y = ((end - start) - value) / 2 + offset
                    case .end:
                        l.view.frame.origin.y = end - value + offset
                    }
                case .stretch(let margin):
                    l.view.frame.size.height = end - start - margin.start - margin.end
                    l.view.frame.origin.y = start + margin.start
                }
            }
        case .vertical:
            for l in layouts {
                switch l.cross {
                case .fixed(let value, let offset, let align):
                    l.view.frame.size.width = value
                    switch align {
                    case .start:
                        l.view.frame.origin.x = start + offset
                    case .center:
                        l.view.frame.origin.x = ((end - start) - value) / 2 + offset
                    case .end:
                        l.view.frame.origin.x = end - value + offset
                    }
                case .stretch(let margin):
                    l.view.frame.size.width = end - start - margin.start - margin.end
                    l.view.frame.origin.x = start + margin.start
                }
            }
        }
    }
    
    public static func layout(_ direction: FlexLayout.Direction, align: FlexLayout.Align = .start, frame: CGRect, @FlexLayout _ builder: () -> [FlexLayout]) {
        switch direction {
        case .horizontal:
            layout(direction, align: align, ms: frame.minX, me: frame.maxX, cs: frame.minY, ce: frame.maxY, builder)
        case .vertical:
            layout(direction, align: align, ms: frame.minY, me: frame.maxY, cs: frame.minX, ce: frame.maxX, builder)
        }
    }
    
    public static func layout(_ direction: FlexLayout.Direction, align: FlexLayout.Align = .start, size: CGSize, @FlexLayout _ builder: () -> [FlexLayout]) {
        switch direction {
        case .horizontal:
            layout(direction, align: align, ms: 0, me: size.width, cs: 0, ce: size.height, builder)
        case .vertical:
            layout(direction, align: align, ms: 0, me: size.height, cs: 0, ce: size.width, builder)
        }
    }
    
    
    public static func H(_ align: FlexLayout.Align = .start,  frame: CGRect, @FlexLayout _ builder: () -> [FlexLayout]) {
        layout(.horizontal, align: align, ms: frame.minX, me: frame.maxX, cs: frame.minY, ce: frame.maxY, builder)
    }
    
    public static func H(_ align: FlexLayout.Align = .start,  size: CGSize, @FlexLayout _ builder: () -> [FlexLayout]) {
        layout(.horizontal, align: align, ms: 0, me: size.width, cs: 0, ce: size.height, builder)
    }
    
    public static func V(_ align: FlexLayout.Align = .start,  frame: CGRect, @FlexLayout _ builder: () -> [FlexLayout]) {
        layout(.vertical, align: align, ms: frame.minY, me: frame.maxY, cs: frame.minX, ce: frame.maxX, builder)
    }
    
    public static func V(_ align: FlexLayout.Align = .start,  size: CGSize, @FlexLayout _ builder: () -> [FlexLayout]) {
        layout(.vertical, align: align, ms: 0, me: size.height, cs: 0, ce: size.width, builder)
    }
    
    /// Layout stack
    /// - Parameters:
    ///   - direction: Main axis direction
    ///   - align: Main axis align
    ///   - ms: Main axis start value
    ///   - me: Main axis end value
    ///   - cs: Corss axis start value
    ///   - ce: Corss axis end value
    ///   - builder: builder
    public static func layout(_ direction: FlexLayout.Direction, align: FlexLayout.Align = .start, ms: CGFloat = 0, me: CGFloat, cs: CGFloat = 0, ce: CGFloat, @FlexLayout _ builder: () -> [FlexLayout]) {
        let layout = builder()
        FlexLayout.layoutMainAxis(layouts: layout, direction: direction, align: align, start: ms, end: me)
        FlexLayout.layoutCorssAxis(layouts: layout, direction: direction, start: cs, end: ce)
        for l in layout {
            if let v = l.view as? Virtual {
                v.builder(v.frame)
            } else if let v = l.view as? Bind {
                v.builder(v.frame)
            }
        }
    }
}
