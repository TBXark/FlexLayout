# FlexLayout

[![CI Status](https://img.shields.io/travis/tbxark/FlexLayout.svg?style=flat)](https://travis-ci.org/tbxark/FlexLayout)
[![Version](https://img.shields.io/cocoapods/v/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)
[![License](https://img.shields.io/cocoapods/l/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)
[![Platform](https://img.shields.io/cocoapods/p/FlexLayout.svg?style=flat)](https://cocoapods.org/pods/FlexLayout)


`FlexLayout` is a flexible layout tool similar to SwiftUI syntax， `ConstraintLayout` is the syntactic sugar of  `NSLayoutAnchor`.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![demo](./demo.jpeg)


```swift

FL.V(frame: view.bounds) {
    FL.Space.fixed(40)
    FL.Bind(userInfoContent) { rect in
        FL.H(size: rect.size) {
            FL.Space.fixed(20)
            avatarImgv.stack(main: .fixed(60), cross: .fixed(60, offset: 20, align: .start))
            FL.Space.fixed(20)
            FL.Virtual { rect in
                FL.V(frame: rect) {
                    FL.Space.fixed(20)
                    titleLabel.stack(main: .fixed(30))
                    FL.Space.grow()
                    FL.Virtual { rect in
                        FL.H(frame: rect) {
                            linkName.stack(main: .fixed(40))
                            linkLabel.stack(main: .grow)
                        }
                    }.stack(main: .fixed(20))
                    FL.Space.fixed(20)
                }
            }.stack(main: .grow)
            FL.Space.fixed(20)
        }
    }.stack(main: .fixed(100), cross: .stretch(margin: (start: 20, end: 20)))
    FL.Space.grow()
    bottomBar.stack(main: .fixed(60), cross: .stretch(margin: (start: 20, end: 20)))
    FL.Space.fixed(40)
}


CL.layout(clTest) {
    clTest.centerXAnchor |== view.centerXAnchor
    clTest.centerYAnchor |== view.centerYAnchor + 100
    (clTest.heightAnchor & clTest.widthAnchor) |== 100
}

CL.layout(clTest2) {
    clTest2.sizeAnchor |== clTest.widthAnchor
    clTest2.centerXAnchor |== clTest.centerXAnchor
    clTest2.bottomAnchor |== bottomBar.topAnchor
}


```

## Requirements

Swift, iOS 9.0+


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
