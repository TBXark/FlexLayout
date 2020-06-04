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
        scrollView.frame = view.bounds
        let width = view.bounds.width
        var maxY = CGFloat(80)
        
        
        do {
            let demo = DemoView(frame: CGRect(x: 0, y: maxY, width: width, height: 100))
            FlexLayout.layout(size: [
                .fixed(view: demo.red, value: 20),
                .grow(view: demo.blue, scale: 1),
                .grow(view: demo.green, scale: 2)
            ], direction: .horizontal, align: .start, start: 0, end: width, space: .fixed(value: 10))
            
            FlexLayout.layout(cross: [
                .fixed(view: demo.red, value: 20, offset: 0, align: .start),
                .fixed(view: demo.blue, value: 30, offset: -10, align: .end),
                .stretch(view: demo.green, margin: .init(top: 10, left: 0, bottom: 10, right: 0))
            ], direction: .horizontal, align: .start, start: 0, end: 100)
            maxY = demo.frame.maxY + 20
            scrollView.addSubview(demo)
        }
        
        
        do {
            let demo = DemoView(frame: CGRect(x: 0, y: maxY, width: width, height: 100))
            FlexLayout.layout(size: [
                .fixed(view: demo.red, value: 60),
                .fixed(view: demo.blue, value: 60),
                .fixed(view: demo.green, value: 60)
            ], direction: .horizontal, align: .start, start: 0, end: width, space: .grow(scale: 1))
            
            FlexLayout.layout(cross: [
                .stretch(view: demo.red, margin: .init(top: 10, left: 0, bottom: 10, right: 0)),
                .stretch(view: demo.blue, margin: .init(top: 10, left: 0, bottom: 10, right: 0)),
                .stretch(view: demo.green, margin: .init(top: 10, left: 0, bottom: 10, right: 0))
            ], direction: .horizontal, align: .start, start: 0, end: 100)
            
            maxY = demo.frame.maxY + 20
            scrollView.addSubview(demo)
        }
        
        do {
            let demo = DemoView(frame: CGRect(x: 0, y: maxY, width: width, height: 400))
            FlexLayout.layout(size: [
                .space(.fixed(value: 0)),
                .fixed(view: demo.red, value: 60),
                .fixed(view: demo.blue, value: 60),
                .fixed(view: demo.green, value: 60),
                .space(.fixed(value: 0)),
            ], direction: .vertical, align: .start, start: 0, end: 400, space: .grow(scale: 1))
            
            FlexLayout.layout(cross: [
                .fixed(view: demo.red, value: 100, offset: 0, align: .start),
                .fixed(view: demo.blue, value: 100, offset: 0, align: .center),
                .fixed(view: demo.green, value: 100, offset: 0, align: .end)
            ], direction: .vertical, align: .center, start: 0, end: width)
            
            maxY = demo.frame.maxY + 20
            scrollView.addSubview(demo)
        }
        
        scrollView.contentSize = CGSize(width: width, height: maxY)

        view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

