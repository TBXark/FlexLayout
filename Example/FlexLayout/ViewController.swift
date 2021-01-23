//
//  ViewController.swift
//  FlexLayout
//
//  Created by tbxark on 06/04/2020.
//  Copyright (c) 2020 tbxark. All rights reserved.
//

import UIKit
import FlexLayout

class ViewController: UIViewController {
    
    
    let userInfoContent = UIView().then({
        $0.backgroundColor = UIColor(white: 0.9, alpha: 1)
    })
    let avatarImgv = UIImageView().then({
        $0.backgroundColor = UIColor.darkGray
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
    })
    let titleLabel = UILabel().then({
        $0.text = "TBXark"
        $0.textColor = UIColor.darkText
    })
    
    let linkName = UILabel().then({
        $0.text = "Github"
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 10)
    })
    let linkLabel = UILabel().then({
        $0.text = "https://github.com/tbxark"
        $0.textColor = UIColor.blue
        $0.font = UIFont.systemFont(ofSize: 10)
    })
    
    let bottomBar = UIView().then({
        $0.backgroundColor = UIColor.black
        $0.layer.cornerRadius = 30
        $0.layer.masksToBounds = true
    })
    
    let clTest = UIView().then({
        $0.backgroundColor = UIColor.yellow
    })
    let clTest2 = UIView().then({
        $0.backgroundColor = UIColor.red
    })

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        userInfoContent.addSubview(avatarImgv)
        userInfoContent.addSubview(titleLabel)
        userInfoContent.addSubview(linkName)
        userInfoContent.addSubview(linkLabel)
        view.addSubview(userInfoContent)
        view.addSubview(bottomBar)
        view.addSubview(clTest)
        view.addSubview(clTest2)

        reloadFlexLayout()
        
        CL.layout(clTest) {
            clTest.centerXAnchor |== view.centerXAnchor
            clTest.centerYAnchor |== view.centerYAnchor + 100
            (clTest.heightAnchor & clTest.widthAnchor) |== 100
        }
        CL.layout(clTest2) {
            clTest2.heightAnchor |== clTest.widthAnchor
            clTest2.widthAnchor |== clTest.widthAnchor * 2 + 100
            clTest2.centerXAnchor |== clTest.centerXAnchor
            clTest2.bottomAnchor |== bottomBar.topAnchor
        }
    }
    
    private func reloadFlexLayout() {
        FL.V(frame: view.bounds) {
            if #available(iOS 11.0, *) {
                FL.Space.fixed(self.view.safeAreaInsets.top)
            } else {
                FL.Space.fixed(20)
            }
            FL.Bind(userInfoContent) { rect in
                FL.H(size: rect.size) {
                    FL.Space.fixed(20)
                    self.avatarImgv.with(main: .fixed(60), cross: .fixed(60, offset: 0, align: .center))
                    FL.Space.fixed(20)
                    FL.Virtual { rect in
                        FL.V(frame: rect) {
                            self.titleLabel.with(main: .fixed(30))
                            FL.Space.grow()
                            FL.Virtual { rect in
                                FL.H(frame: rect) {
                                    self.linkName.with(main: .fixed(40))
                                    self.linkLabel.with(main: .grow)
                                }
                            }.with(main: .fixed(20))
                        }
                    }.with(main: .grow, cross: .fixed(60, offset: 0, align: .center))
                    FL.Space.fixed(20)
                }
            }.with(main: .fixed(100), cross: .stretch(margin: (start: 20, end: 20)))
            FL.Space.grow()
            self.bottomBar.with(main: .fixed(60), cross: .stretch(margin: (start: 20, end: 20)))
            if #available(iOS 11.0, *) {
                FL.Space.fixed(self.view.safeAreaInsets.bottom)
            } else {
                FL.Space.fixed(20)
            }
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        reloadFlexLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


protocol Then {
}

extension Then where Self: AnyObject {
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {
}
