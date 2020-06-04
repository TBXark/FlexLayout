//
//  ViewController.swift
//  FlexLayout
//
//  Created by tbxark on 06/04/2020.
//  Copyright (c) 2020 tbxark. All rights reserved.
//

import UIKit
import FlexLayout

class DemoView: UIView {
    
    class SizeLabel: UILabel {
        override var frame: CGRect {
            didSet {
                font = UIFont.systemFont(ofSize: frame.size.width/5)
                text = "\(Int(frame.size.width))x\(Int(frame.size.height))"
            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            textAlignment = .center
            textColor = UIColor.white
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    let red = SizeLabel()
    let blue = SizeLabel()
    let green = SizeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.yellow
        red.backgroundColor = UIColor.red
        blue.backgroundColor = UIColor.blue
        green.backgroundColor = UIColor.green
        addSubview(red)
        addSubview(blue)
        addSubview(green)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let demo1 = DemoView()
        let demo2 = DemoView()
        let demo3 = DemoView()
        
        // Layout scrollView
        do {
            scrollView.frame = view.bounds
            
            FlexLayout.layout(size: [
                .space(.fixed(value: 80)),
                .fixed(view: demo1, value: 100),
                .fixed(view: demo2, value: 100),
                .fixed(view: demo3, value: 400)
            ], direction: .vertical, align: .start, start: 0, end: CGFloat.infinity, space: .fixed(value: 20))
            
            FlexLayout.layout(cross: [
                .stretch(view: demo1),
                .stretch(view: demo2),
                .stretch(view: demo3, margin: .init(top: 0, left: 10, bottom: 0, right: 10))
            ], direction: .vertical, end: scrollView.bounds.width)
            
            
            scrollView.alwaysBounceVertical = true
            scrollView.contentSize = CGSize(width: view.bounds.width, height: demo3.frame.maxY)
            
            view.addSubview(scrollView)
        }
        
        
        // Layout demo1
        do {
            FlexLayout.layout(size: [
                .fixed(view: demo1.red, value: 20),
                .grow(view: demo1.blue, scale: 1),
                .grow(view: demo1.green, scale: 2)
            ], direction: .horizontal, align: .start, start: 0, end: demo1.bounds.width, space: .fixed(value: 10))
            
            FlexLayout.layout(cross: [
                .fixed(view: demo1.red, value: 20, offset: 0, align: .start),
                .fixed(view: demo1.blue, value: 30, offset: -10, align: .end),
                .stretch(view: demo1.green, margin: .init(top: 10, left: 0, bottom: 10, right: 0))
            ], direction: .horizontal, align: .start, start: 0, end:  demo2.bounds.height)
            scrollView.addSubview(demo1)
        }
        
        // Layout demo2
        do {
            FlexLayout.layout(size: [
                .fixed(view: demo2.red, value: 60),
                .fixed(view: demo2.blue, value: 60),
                .fixed(view: demo2.green, value: 60)
            ], direction: .horizontal, align: .start, start: 0, end: demo2.bounds.width, space: .grow(scale: 1))
            
            FlexLayout.layout(cross: [
                .stretch(view: demo2.red, margin: .init(top: 10, left: 0, bottom: 10, right: 0)),
                .stretch(view: demo2.blue, margin: .init(top: 10, left: 0, bottom: 10, right: 0)),
                .stretch(view: demo2.green, margin: .init(top: 10, left: 0, bottom: 10, right: 0))
            ], direction: .horizontal, align: .start, start: 0, end: demo2.bounds.height)
            scrollView.addSubview(demo2)
        }
        
        // Layout demo3
        do {
            FlexLayout.layout(size: [
                .space(.fixed(value: 0)),
                .fixed(view: demo3.red, value: 60),
                .fixed(view: demo3.blue, value: 60),
                .fixed(view: demo3.green, value: 60),
                .space(.fixed(value: 0)),
            ], direction: .vertical, align: .start, start: 0, end: demo3.bounds.height, space: .grow(scale: 1))
            
            FlexLayout.layout(cross: [
                .fixed(view: demo3.red, value: 100, offset: 0, align: .start),
                .fixed(view: demo3.blue, value: 100, offset: 0, align: .center),
                .fixed(view: demo3.green, value: 100, offset: 0, align: .end)
            ], direction: .vertical, align: .center, start: 0, end: demo3.bounds.width)
            scrollView.addSubview(demo3)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

