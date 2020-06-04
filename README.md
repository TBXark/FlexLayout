# FlexLayout

[![CI Status](https://img.shields.io/travis/tbxark/FlexLayout.svg?style=flat)](https://travis-ci.org/tbxark/FlexLayout)
[![Version](https://img.shields.io/cocoapods/v/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)
[![License](https://img.shields.io/cocoapods/l/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)
[![Platform](https://img.shields.io/cocoapods/p/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![demo](./demo.jpeg)


```swift


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


```

## Requirements

Swift, iOS 8.0+


## Installation

FlexLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FlexLayout', :git=>'https://github.com/tbxark/FlexLayout.git'
```

## Author

tbxark, tbxark@outlook.com

## License

FlexLayout is available under the MIT license. See the LICENSE file for more info.
