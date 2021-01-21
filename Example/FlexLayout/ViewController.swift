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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
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

        
        userInfoContent.addSubview(avatarImgv)
        userInfoContent.addSubview(titleLabel)
        userInfoContent.addSubview(linkName)
        userInfoContent.addSubview(linkLabel)
        view.addSubview(userInfoContent)
        view.addSubview(bottomBar)
        view.addSubview(clTest)
        view.addSubview(clTest2)

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
