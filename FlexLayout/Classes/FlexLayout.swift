//
//  FlexLayout.swift
//  FlexLayout
//
//  Created by tbxark on 06/04/2020.
//  Copyright (c) 2020 tbxark. All rights reserved.
//

import  UIKit

public struct FlexLayout {
    
    public enum Space {
        case grow(scale: CGFloat)
        case fixed(value: CGFloat)
    }
    
    public enum Size {
        case space(Space)
        case grow(view: UIView, scale: CGFloat)
        case fixed(view: UIView, value: CGFloat)
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
        case fixed(view: UIView, value: CGFloat, offset: CGFloat? = nil, align: Align? = nil)
        case stretch(view: UIView, margin: UIEdgeInsets? = nil)
    }
    
    
    // The default layout is space-arround |-[a]-[b]-[c]-|, If you want space-between, add .space(.fixed(value: 0)) at the beginning and end of `size`
    static public func layout(size: [Size], direction: Direction, align: Align = .start, start: CGFloat = 0, end: CGFloat, space: Space = .fixed(value: 0)) {
        
        var fixed = [(view: UIView, size: CGFloat)]()
        var grow = [(view: UIView, grow: CGFloat)]()
        
        var totalSize = CGFloat.zero
        var totalGrow = CGFloat.zero
        
        var nextSpace = space
        
        for s in size {
            switch s {
            case .fixed(let view, let value):
                switch space {
                case .fixed(let _value):
                    totalSize += _value
                case .grow(let _scale):
                    totalGrow += _scale
                }
                totalSize += value
                nextSpace = space
                fixed.append((view: view, size: value))
            case .grow(let view, let scale):
                switch space {
                case .fixed(let _value):
                    totalSize += _value
                case .grow(let _scale):
                    totalGrow += _scale
                }
                totalGrow += scale
                nextSpace = space
                grow.append((view: view, grow: scale))
            case .space(let value):
                nextSpace = value
            }
        }
        switch space {
        case .fixed(let _value):
            totalSize += _value
        case .grow(let _scale):
            totalGrow += _scale
        }
        
        let growValue = (end - start - totalSize)/totalGrow
        var startPosition = start
        
        if totalGrow.isZero {
            switch align {
            case .start:
                startPosition = start
            case .center:
                startPosition = start + (end - start - totalSize)/2
            case .end:
                startPosition = (end - totalSize)
            }
        }
        

        nextSpace = space
        switch direction {
        case .horizontal:
            for s in size {
                switch s {
                case .grow(let view, let scale):
                    var spaceValue = CGFloat.zero
                    switch nextSpace {
                    case .fixed(let value):
                        spaceValue = value
                    case .grow(let scale):
                        spaceValue = scale * growValue
                    }
                    view.frame.origin.x = startPosition + spaceValue
                    view.frame.size.width = scale * growValue
                    startPosition = view.frame.maxX
                    nextSpace = space
                case .fixed(let view, let value):
                    var spaceValue = CGFloat.zero
                    switch nextSpace {
                    case .fixed(let value):
                         spaceValue = value
                    case .grow(let scale):
                         spaceValue = scale * growValue
                    }
                    view.frame.origin.x = startPosition + spaceValue
                    view.frame.size.width = value
                    startPosition = view.frame.maxX
                    nextSpace = space
                case .space(let value):
                    nextSpace = value
                }
            }
        case .vertical:
            for s in size {
                switch s {
                case .grow(let view, let scale):
                    var spaceValue = CGFloat.zero
                    switch nextSpace {
                    case .fixed(let value):
                        spaceValue = value
                    case .grow(let scale):
                        spaceValue = scale * growValue
                    }
                    view.frame.origin.y = startPosition + spaceValue
                    view.frame.size.height = scale * growValue
                    startPosition = view.frame.maxY
                    nextSpace = space
                case .fixed(let view, let value):
                    var spaceValue = CGFloat.zero
                    switch nextSpace {
                    case .fixed(let value):
                         spaceValue = value
                    case .grow(let scale):
                         spaceValue = scale * growValue
                    }
                    view.frame.origin.y = startPosition + spaceValue
                    view.frame.size.height = value
                    startPosition = view.frame.maxY
                    nextSpace = space
                case .space(let value):
                    nextSpace = value
                }
            }
            
        }
    }
    
    
    public static func layout(cross: [Cross], direction: Direction, align: Align = .start, start: CGFloat = 0, end: CGFloat) {
        switch direction {
        case .horizontal:
            for c in cross {
                switch c {
                case .fixed(let view, let value, let offset, let _align):
                    view.frame.size.height = value
                    switch _align ?? align {
                    case .start:
                        view.frame.origin.y = start + (offset ?? 0)
                    case .center:
                        view.frame.origin.y = ((end - start) - value)/2 + (offset ?? 0)
                    case .end:
                        view.frame.origin.y =  end - value + (offset ?? 0)
                    }
                case .stretch(let view, let margin):
                    view.frame.size.height = end - start - (margin?.bottom ?? 0) - (margin?.top ?? 0)
                    view.frame.origin.y = margin?.top ?? 0
                }
            }
        case .vertical:
            for c in cross {
                switch c {
                case .fixed(let view, let value, let offset, let _align):
                    view.frame.size.width = value
                    switch _align ?? align {
                    case .start:
                        view.frame.origin.x = start + (offset ?? 0)
                    case .center:
                        view.frame.origin.x = ((end - start) - value)/2 + (offset ?? 0)
                    case .end:
                        view.frame.origin.x =  end - value + (offset ?? 0)
                    }
                case .stretch(let view, let margin):
                    view.frame.size.width = end - start - (margin?.left ?? 0) - (margin?.right ?? 0)
                    view.frame.origin.x = margin?.left ?? 0
                }
            }
        }
    }
}

